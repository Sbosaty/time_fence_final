

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/model/user_model.dart';
import 'package:time_fence/screen/admin_screen/employee/add_salary_screen.dart';
import 'package:time_fence/unit/source.dart';

class SalaryEmpScreen extends StatefulWidget {
  final UserModel userModel;
  const SalaryEmpScreen({super.key, required this.userModel});

  @override
  State<SalaryEmpScreen> createState() => _SalaryEmpScreenState();
}

class _SalaryEmpScreenState extends State<SalaryEmpScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getSalary(uid: widget.userModel.uId??'');
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
              backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
              foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              title: const Text('Salary'),
              actions: [
                const SizedBox(width: 10,),
                IconButton(
                  icon:  Icon(Icons.add,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddSalaryScreen(userModel: widget.userModel);
                    }));
                  },
                ),
                const SizedBox(width: 10,),
              ],
            ),
            body: (state is LoadingGetAllUser || state is LoadingUpdateUser)?
            const Center(child:CircularProgressIndicator()):

            ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: cubit.salaryList.length,
                itemBuilder: (context,index){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical:5),
                    decoration: BoxDecoration(
                        color: cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Date : ${cubit.salaryList[index].date??''}',
                                style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                              const SizedBox(height: 10,),
                              Text('Salary : ${cubit.salaryList[index].salary??''}',
                                style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                              const SizedBox(height: 10,),
                              Text('salaryType : ${cubit.salaryList[index].salaryType??''}',
                                style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                              const SizedBox(height: 10,),
                              Text('Note : ${cubit.salaryList[index].dis??''}',
                                style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: (){
                            cubit.deleteSalary(uid: cubit.salaryList[index].uid??'',uidUser: cubit.salaryList[index].uIdUser??'');
                          },
                        ),

                      ],
                    ),
                  );
                }),
          );
        });
  }
}
