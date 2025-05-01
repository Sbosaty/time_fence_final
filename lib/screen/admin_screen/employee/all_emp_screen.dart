
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/admin_screen/employee/edit_emp_screen.dart';
import 'package:time_fence/unit/source.dart';

import 'salary_emp_screen.dart';

class AllEmpScreen extends StatefulWidget {
  const AllEmpScreen({super.key});

  @override
  State<AllEmpScreen> createState() => _AllEmpScreenState();
}

class _AllEmpScreenState extends State<AllEmpScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllEmp();
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
          title: const Text('All Employees'),
        ),
        body: (state is LoadingGetAllUser)?
        const Center(child:CircularProgressIndicator()):

        ListView.builder(
          padding: const EdgeInsets.all(15),
            itemCount: cubit.empList.length,
            itemBuilder: (context,index){
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical:5),
            decoration: BoxDecoration(
                color:cubit.isDarkTheme ? ColorSource.secColorDark: ColorSource.secColorLight,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name : ${cubit.empList[index].name??''}',
                style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 10,),
                Text('Phone : ${cubit.empList[index].phone??''}',
                  style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 10,),
                Text('Password : ${cubit.empList[index].password??''}',
                  style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 10,),
                Text('Salary : ${cubit.empList[index].salary??0.0}',
                  style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 10,),
                Text('Jop Title : ${cubit.empList[index].jopTitle??0.0}',
                  style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 10,),
                Text('Active : ${cubit.empList[index].isActive??false}',
                  style: TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  EditEmpScreen(
                            userModel: cubit.empList[index],
                          );
                        }));
                      },
                      minWidth: double.infinity,
                      color: ColorSource.pColor,
                      textColor: Colors.white,
                      height: 50,
                      child:  const Text('Details',style: TextStyle(
                          fontSize: 20
                      ),),
                    )),
                    const SizedBox(width: 10,),
                    Expanded(child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  SalaryEmpScreen(
                            userModel: cubit.empList[index],
                          );
                        }));
                      },
                      minWidth: double.infinity,
                      color: ColorSource.pColor,
                      textColor: Colors.white,
                      height: 50,
                      child:  const Text('Salary',style: TextStyle(
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
