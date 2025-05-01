
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/user_screen/Leave_request_screen.dart';
import 'package:time_fence/screen/user_screen/empty_screen.dart';
import 'package:time_fence/screen/user_screen/review_salary_screen.dart';
import 'package:time_fence/unit/source.dart';

class ServicesEmpScreen extends StatefulWidget {
  const ServicesEmpScreen({super.key});

  @override
  State<ServicesEmpScreen> createState() => _ServicesEmpScreenState();
}

class _ServicesEmpScreenState extends State<ServicesEmpScreen> {
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
                              return const LeaveRequestScreen(leaveRequest: false);
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
                                      color: Colors.orange,
                                      shape: BoxShape.circle
                                    ),
                                    child: SvgPicture.asset('assets/image/Leave_request.svg',
                                      color: ColorSource.whiteColor,
                                      height: 30,width: 30,),),
                                const SizedBox(height: 10,),
                                Text('Ask for permission',style: TextStyle(
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
                              return const LeaveRequestScreen(leaveRequest: true);
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
                                        color: Colors.green,
                                        shape: BoxShape.circle
                                    ),
                                    child: SvgPicture.asset('assets/image/Leave_request.svg',
                                      color: ColorSource.whiteColor,
                                      height: 30,width: 30,),),
                                const SizedBox(height: 10,),
                                Text('Leave request',style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const ReviewSalaryScreen();
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
                                  child: SvgPicture.asset('assets/image/salary.svg',
                                    color: ColorSource.whiteColor,
                                    height: 30,width: 30,),),
                                const SizedBox(height: 10,),
                                Text('Review Salary',style: TextStyle(
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
                              return const EmptyScreen(isTasks: false);
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
                                  child: SvgPicture.asset('assets/image/Announcement.svg',
                                    height: 30,width: 30,color: ColorSource.whiteColor,),),
                                const SizedBox(height: 10,),
                                Text('Announcements',style: TextStyle(
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
                              return const EmptyScreen(isTasks: true);
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
                                      color: Colors.deepPurple,
                                      shape: BoxShape.circle
                                  ),
                                  child: SvgPicture.asset('assets/image/tasks.svg',
                                    color: ColorSource.whiteColor,
                                    height: 30,width: 30,),),
                                const SizedBox(height: 10,),
                                Text('Tasks',style: TextStyle(
                                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16
                                ),)

                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 100,
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
