
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/admin_screen/admin/all_admins_screen.dart';
import 'package:time_fence/screen/admin_screen/employee/all_emp_screen.dart';
import 'package:time_fence/screen/admin_screen/leave_screen.dart';
import 'package:time_fence/screen/admin_screen/select_location_screen.dart';
import 'package:time_fence/unit/source.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            appBar: AppBar(
              //elevation: 1,
              title:  Text('Services',
                style: TextStyle(
                  color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                ),),
              backgroundColor:cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const AllAdminsScreen();
                            }));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.teal,
                                      shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.add,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,size: 25,)),
                                const SizedBox(height: 10,),
                                Text('Mangers',style: TextStyle(
                                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16
                                ),)

                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const AllEmpScreen();
                            }));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color:cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.people_alt,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,size: 25,)),
                                const SizedBox(height: 10,),
                                Text('Employees',style: TextStyle(
                                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16
                                ),)

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const LeaveScreen();
                            }));
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.deepPurple,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.calendar_month_outlined,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,size: 25,)),
                                const SizedBox(height: 10,),
                                Text('Leave and Permission',style: TextStyle(
                                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16
                                ),)

                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const SelectLocationScreen();
                            }));
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.location_on_outlined,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,size: 25,)),
                                const SizedBox(height: 10,),
                                Text('Location',style: TextStyle(
                                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16
                                ),)

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        },
        listener: (context,state){

        });
  }
}
