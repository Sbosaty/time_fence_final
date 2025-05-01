import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_fence/bloc/app_cubit.dart';

class AddTimeLogCard extends StatefulWidget {
  const AddTimeLogCard({super.key});

  @override
  _AddTimeLogCardState createState() => _AddTimeLogCardState();
}

class _AddTimeLogCardState extends State<AddTimeLogCard> with WidgetsBindingObserver {
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;
  late DateTime _startTime;
  Duration _elapsed = Duration.zero;
  Duration _pausedElapsed = Duration.zero;
  int endHour = 18;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPersistentState();
  }

  void _onToggleTimer() async {
    final now = DateTime.now();
    const startAllowed = TimeOfDay(hour: 9, minute: 0);
    var endAllowed = TimeOfDay(hour: endHour, minute: 0);
    final nowTime = TimeOfDay.fromDateTime(now);

    bool isWithinAllowedTime = (nowTime.hour > startAllowed.hour ||
        (nowTime.hour == startAllowed.hour && nowTime.minute >= startAllowed.minute)) &&
        (nowTime.hour < endAllowed.hour ||
            (nowTime.hour == endAllowed.hour && nowTime.minute <= endAllowed.minute));

    if (!_isRunning && !isWithinAllowedTime) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only log in between 9am and 6pm'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (_isRunning) {
      _stopTimer();
      prefs.setBool('isRunning', false);
      prefs.setBool('isPaused', false);
      prefs.remove('startTime');
      prefs.setInt('lastElapsed', _elapsed.inSeconds);
      setState(() {
        _isRunning = false;
        _isPaused = false;
      });
    } else {
      _elapsed = Duration.zero;
      _isRunning = true;
      _isPaused = false;
      _startTime = DateTime.now();
      prefs.setBool('isRunning', true);
      prefs.setBool('isPaused', false);
      prefs.setInt('startTime', _startTime.millisecondsSinceEpoch);
      prefs.remove('lastElapsed');
      _startTimer();
      setState(() {});
    }
  }

  Future<bool> isInAllowedArea() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return false;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return false;
  }

  final pos = await Geolocator.getCurrentPosition();
  final distance = Geolocator.distanceBetween(
    BlocProvider.of<AppCubit>(context).allowedLatitude,
    BlocProvider.of<AppCubit>(context).allowedLongitude,
    pos.latitude, pos.longitude,
  );

  return distance <=  BlocProvider.of<AppCubit>(context).allowedRadiusMeters;
}

  Future<void> _loadPersistentState() async {
    final prefs = await SharedPreferences.getInstance();
    final bool wasRunning = prefs.getBool('isRunning') ?? false;
    final bool wasPaused = prefs.getBool('isPaused') ?? false;
    final int? startTimeMillis = prefs.getInt('startTime');
    final int? lastElapsedSecs = prefs.getInt('lastElapsed');

    if (wasRunning && startTimeMillis != null) {
      _isRunning = true;
      _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMillis);

      if (wasPaused) {
        _isPaused = true;
        _pausedElapsed = Duration(seconds: lastElapsedSecs ?? 0);
        _elapsed = _pausedElapsed;
      } else {
        _elapsed = DateTime.now().difference(_startTime);
        _startTimer();
      }
    } else if (lastElapsedSecs != null) {
      _elapsed = Duration(seconds: lastElapsedSecs);
    }
    setState(() {});
  }

  void _startTimer() {
  _timer?.cancel();
  _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
    if (_isRunning && !_isPaused) {
      final now = DateTime.now();
      setState(() {
        _elapsed = now.difference(_startTime);
      });

      final insideZone = await isInAllowedArea();
      if (!insideZone) {
        _togglePause();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have been temporarily suspended because you have left the selected area.')),
        );
      }

      if (now.hour >= endHour) {
        _autoCheckOut();
      }
    }
  });
}



  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }


  Future<void> _autoCheckOut() async {
    final prefs = await SharedPreferences.getInstance();
    _stopTimer();
    prefs.setBool('isRunning', false);
    prefs.setBool('isPaused', false);
    prefs.remove('startTime');
    prefs.setInt('lastElapsed', _elapsed.inSeconds);
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('I was automatically logged out at 6pm'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _togglePause() async {
    final prefs = await SharedPreferences.getInstance();

    if (_isPaused) {
      // Resume
      _startTime = DateTime.now().subtract(_pausedElapsed);
      _startTimer();
      prefs.setBool('isPaused', false);
      setState(() {
        _isPaused = false;
      });
    } else {
      // Pause
      _pausedElapsed = _elapsed;
      _stopTimer();
      prefs.setBool('isPaused', true);
      prefs.setInt('lastElapsed', _pausedElapsed.inSeconds);
      setState(() {
        _isPaused = true;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      if (_isRunning && !_isPaused) {
        _startTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final int hours = _elapsed.inHours;
    final int minutes = _elapsed.inMinutes.remainder(60);
    final int seconds = _elapsed.inSeconds.remainder(60);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String hoursStr = twoDigits(hours);
    final String minsStr = twoDigits(minutes);
    final String secsStr = twoDigits(seconds);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeBox(label: hoursStr),
              const SizedBox(width: 8),
              _TimeBox(label: minsStr),
              const SizedBox(width: 8),
              _TimeBox(label: secsStr),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('HRS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800])),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 8),
          Text('GENERAL 09:00 AM TO 06:00 PM',
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: (){
              _onToggleTimer();
             if(_isRunning){
               BlocProvider.of<AppCubit>(context).addHour(hour: int.parse(hoursStr), min: int.parse(minsStr));
             }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
            ),
            child: Text(
              _isRunning ? 'Check-Out' : 'Check-In',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          if (_isRunning) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _togglePause,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                _isPaused ? 'Resume' : 'Pause',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  final String label;
  const _TimeBox({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}






/*<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to track working zone.</string>*/


/////
/*<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>نحتاج إلى الوصول إلى الموقع لتوفير أفضل تجربة للمستخدم.</string>
<key>UIBackgroundModes</key>
<array>
<string>location</string>
</array>*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geofence_foreground_service/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';*/

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GeofenceForegroundService().initialize();
  runApp(const MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  bool _isRunning = false;
  Duration _elapsed = Duration.zero;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    setupGeofencing();
    _loadState();
  }

  Future<void> requestPermissions() async {
    await Permission.locationAlways.request();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _isRunning = prefs.getBool('isRunning') ?? false;
    int? startTimeMillis = prefs.getInt('startTime');
    if (_isRunning && startTimeMillis != null) {
      _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMillis);
      _elapsed = DateTime.now().difference(_startTime);
      _startTimer();
    } else {
      _elapsed = Duration(seconds: prefs.getInt('lastElapsed') ?? 0);
    }
    setState(() {});
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed = DateTime.now().difference(_startTime);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> toggleTimer(bool start) async {
    final prefs = await SharedPreferences.getInstance();
    if (start) {
      _startTime = DateTime.now();
      _isRunning = true;
      prefs.setBool('isRunning', true);
      prefs.setInt('startTime', _startTime.millisecondsSinceEpoch);
      _startTimer();
    } else {
      _isRunning = false;
      _stopTimer();
      prefs.setBool('isRunning', false);
      prefs.remove('startTime');
      prefs.setInt('lastElapsed', _elapsed.inSeconds);
    }
    setState(() {});
  }

  void setupGeofencing() async {
    const LatLng center = LatLng(30.0444, 31.2357); // Example: Cairo
    final zone = Zone(
      id: 'zone1',
      radius: 150,
      coordinates: [center],
      triggers: [GeofenceEventType.enter, GeofenceEventType.exit],
      expirationDuration: const Duration(days: 365),
    );

    await GeofenceForegroundService().startGeofencingService(
      contentTitle: 'تتبع موقعك مفعل',
      contentText: 'المؤقت يعمل حسب الموقع الجغرافي',
      notificationChannelId: 'geo_service_channel',
      serviceId: 777,
      callbackDispatcher: callbackDispatcher,
    );
    await GeofenceForegroundService().addGeofenceZone(zone);
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String h = twoDigits(_elapsed.inHours);
    final String m = twoDigits(_elapsed.inMinutes.remainder(60));
    final String s = twoDigits(_elapsed.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل وقت العمل")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$h:$m:$s', style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => toggleTimer(!_isRunning),
              child: Text(_isRunning ? 'Check Out' : 'Check In'),
            ),
          ],
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  GeofenceForegroundService().handleTrigger(
    backgroundTriggerHandler: (zoneID, triggerType) async {
      final prefs = await SharedPreferences.getInstance();
      final isRunning = prefs.getBool('isRunning') ?? false;

      if (triggerType == GeofenceEventType.exit && isRunning) {
        prefs.setBool('isRunning', false);
        final startMillis = prefs.getInt('startTime');
        if (startMillis != null) {
          final elapsed = DateTime.now().difference(
              DateTime.fromMillisecondsSinceEpoch(startMillis));
          prefs.setInt('lastElapsed', elapsed.inSeconds);
          prefs.remove('startTime');
        }
      } else if (triggerType == GeofenceEventType.enter && !isRunning) {
        prefs.setBool('isRunning', true);
        prefs.setInt('startTime', DateTime.now().millisecondsSinceEpoch);
      }
      return true;
    },
  );
}*/

