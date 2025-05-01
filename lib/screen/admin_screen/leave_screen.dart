
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getLeaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            appBar: AppBar(
              backgroundColor:  cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
              foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              title: const Text('All Request'),
            ),
            body: (state is LoadingGetAllUser)?
            const Center(child:CircularProgressIndicator()):

            ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: cubit.leaveList.length,
                itemBuilder: (context,index){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical:5),
                    decoration: BoxDecoration(
                        color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Name Employee : ${cubit.leaveList[index].name??''}',
                          style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                        const SizedBox(height: 10,),
                        Text('Phone Employee : ${cubit.leaveList[index].phone??''}',
                          style:  TextStyle(color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                        const SizedBox(height: 10,),
                        Text('Date : ${cubit.leaveList[index].date??''}',
                          style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                        const SizedBox(height: 10,),
                        Text('Time : ${cubit.leaveList[index].time??0.0}',
                          style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                        const SizedBox(height: 10,),
                        Text('Note : ${cubit.leaveList[index].note??0.0}',
                          style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: MaterialButton(
                              onPressed: ()async{
                                try{
                                  await launchUrl(Uri.parse(cubit.leaveList[index].link??''));
                                }catch(e){
                                  debugPrint(e.toString());
                                }
                              },
                              minWidth: double.infinity,
                              color: ColorSource.pColor,
                              textColor: Colors.white,
                              height: 50,
                              child:  const Text('Go Link',style: TextStyle(
                                  fontSize: 18
                              ),),
                            )),
                            const SizedBox(width: 10,),
                            Expanded(child: MaterialButton(
                              onPressed: ()async{
                                try{
                                  await launchUrl(Uri(
                                    scheme: 'tel',
                                    path: cubit.leaveList[index].phone??'',
                                  ));
                                }catch(e){
                                  debugPrint(e.toString());
                                }
                              },
                              minWidth: double.infinity,
                              color: ColorSource.pColor,
                              textColor: Colors.white,
                              height: 50,
                              child:  const Text('Call',style: TextStyle(
                                  fontSize: 20
                              ),),
                            )),


                          ],
                        )

                      ],
                    ),
                  );
                }),
          );
        });
  }
}
