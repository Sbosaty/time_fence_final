
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/admin_screen/home_admin.dart';
import 'package:time_fence/screen/admin_screen/layout_admin.dart';
import 'package:time_fence/screen/user_screen/home_screen.dart';
import 'package:time_fence/screen/auth_screen/login_screen.dart';
import 'package:time_fence/screen/user_screen/layout_emp.dart';
import 'package:time_fence/unit/source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), (){
      if(FirebaseAuth.instance.currentUser!=null){
        BlocProvider.of<AppCubit>(context).getDateUser();
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
          return LoginScreen();
        }), (_)=>false);
      }
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is SuccessGetUserScreen){
          if(BlocProvider.of<AppCubit>(context).userModel?.isActive??false){
            if((BlocProvider.of<AppCubit>(context).userModel?.typeAccount??'') == 'Emp'){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                return const LayoutEmp();
              }), (_)=>false);
            }else{
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                return const LayoutAdmin();
              }), (_)=>false);
            }
          }else{
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
              return LoginScreen();
            }), (_)=>false);
          }
        }else if(state is ErrorGetUserScreen){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
            return LoginScreen();
          }), (_)=>false);
        }

      },
        builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
          body: Center(
            child: Image.asset('assets/image/logo.png',
              width: MediaQuery.of(context).size.width*0.6,
            ),
          ),
        );
        },
    );
  }
}
