import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/firebase_options.dart';
import 'package:time_fence/screen/auth_screen/splash_screen.dart';
import 'package:time_fence/unit/shared_pref_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider (create: (BuildContext context) => AppCubit()..checkStateDarkTheme(),),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Fence',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}



