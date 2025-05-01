
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class ProfileAdminScreen extends StatelessWidget {
  const ProfileAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorSource.whiteColor
                          ),
                          child: const Icon(FontAwesomeIcons.user,size: 25,),
                        ),
                        const SizedBox(width: 10,),
                        Text('Profile',
                          style: TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            fontSize: 20
                          ),),
                        const Spacer(),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            cubit.changeStateDarkTheme();
                          },
                          child: Icon(cubit.isDarkTheme?Icons.light_mode:Icons.dark_mode,color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,size: 30,),
                        ),
                        const SizedBox(width: 10,),
                        IconButton(
                          icon: Icon(Icons.logout,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor),
                          onPressed: (){
                            cubit.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.notifications_active_outlined,
                              size: 25,
                              color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                              const SizedBox(width: 10,),
                              Text('Notifications',style: TextStyle(
                                fontSize: 15,
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),

                            ],
                          ),
                          const SizedBox(height: 5,),
                          const Divider(),
                          const SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.help_outline_sharp,
                              size: 25,
                              color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                              const SizedBox(width: 10,),
                              Text('About',style: TextStyle(
                                fontSize: 15,
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),


                            ],
                          ),
                          const SizedBox(height: 5,),
                          const Divider(),
                          const SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.contact_emergency,
                                size: 25,
                                color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                              const SizedBox(width: 10,),
                              Text('Contact us',style: TextStyle(
                                fontSize: 15,
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color:  cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),


                            ],
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        },
        listener: (context,state){

        });
  }
}
