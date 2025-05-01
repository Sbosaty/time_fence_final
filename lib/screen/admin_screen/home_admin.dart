
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/card_user.dart';
import 'package:time_fence/unit/source.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            appBar: AppBar(
              title:  Text('Manger Section',
              style: TextStyle(
                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              ),),
              backgroundColor:cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
            ),
            body: const Padding(
              padding:  EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  EmployeeIDCard(),
                ],
              ),
            ),
          );
        },
        listener: (context,state){
        });
  }
}
