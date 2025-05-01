
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  var formKey=GlobalKey<FormState>();
  var latController=TextEditingController();
  var longController=TextEditingController();
  var rediasController=TextEditingController();

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            appBar: AppBar(
              backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
              foregroundColor:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              title: const Text('Location Information'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: latController,
                        keyboardType: TextInputType.name,
                        style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          hintText: 'latitude',
                          hintStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          labelStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          contentPadding:const  EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The latitude';
                          }
                        },
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        keyboardType:TextInputType.number ,
                        controller: longController,
                        style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          hintText: 'Longitude',
                          hintStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          labelStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          contentPadding:const  EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The longitude';
                          }
                        },
                      ),

                      const SizedBox(height: 15,),
                      TextFormField(
                        keyboardType:TextInputType.number ,
                        controller: rediasController,
                        style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Radius',
                          hintText: 'Radius',
                          hintStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          labelStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          contentPadding:const  EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The radius';
                          }
                        },
                      ),



                      const SizedBox(height: 20,),
                      MaterialButton(
                        onPressed: ()async{
                          try {
                            Position position = await LocationService.getCurrentLocation();

                            latController.text = position.latitude.toString();
                            longController.text = position.longitude.toString();

                            setState(() {});

                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error : $e')),
                            );
                          }

                        },
                        minWidth: double.infinity,
                        color: ColorSource.pColor,
                        textColor: Colors.white,
                        height: 50,
                        child:  const Text('Select Current Location',style: TextStyle(
                            fontSize: 20
                        ),),
                      ),

                      const SizedBox(height: 25,),
                      (state is LoadingSelectLocation)?
                      const Center(child:CircularProgressIndicator()):
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            cubit.editLocation(lat: latController.text,
                                long: longController.text,
                                redies: rediasController.text);
                          }
                        },
                        minWidth: double.infinity,
                        color: ColorSource.pColor,
                        textColor: Colors.white,
                        height: 50,
                        child:  const Text('Edit Location',style: TextStyle(
                            fontSize: 20
                        ),),
                      )

                    ],
                  ),
                ),
              ),
            ),

          );
        }, listener: (context,state){
          if(state is SuccessGetLocation){
            latController.text = BlocProvider.of<AppCubit>(context).allowedLatitude.toString();
            longController.text = BlocProvider.of<AppCubit>(context).allowedLongitude.toString();
            rediasController.text = BlocProvider.of<AppCubit>(context).allowedRadiusMeters.toString();
          } else if (state is ErrorSelectLocation){
        Fluttertoast.showToast(
          msg: 'Check in information',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }else if (state is SuccessSelectLocation){
        Navigator.pop(context);

      }
    });
  }
}


class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('The website service is not activated');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Access to the site has been denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Access to the site is permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

