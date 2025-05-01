
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class ReviewSalaryScreen extends StatefulWidget {
  const ReviewSalaryScreen({super.key});

  @override
  State<ReviewSalaryScreen> createState() => _ReviewSalaryScreenState();
}

class _ReviewSalaryScreenState extends State<ReviewSalaryScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getSalary(uid: BlocProvider.of<AppCubit>(context).userModel?.uId??'');
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
          title: const Text('Review Salary'),
          foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
          backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
        ),
        body:  (state is LoadingGetAllUser)?
        const Center(child:CircularProgressIndicator()): ListView.builder(
            itemCount: cubit.salaryList.length,
            padding: const EdgeInsets.all(10),
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
                    Text('Date Month in year : ${cubit.salaryList[index].date??''}',
                      style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Salary : ${cubit.salaryList[index].salary??''}',
                      style: TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('salaryType : ${cubit.salaryList[index].salaryType??''}',
                      style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Note : ${cubit.salaryList[index].dis??''}',
                      style: TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                  ],
                ),
              );
            }),

      );
    }, listener: (context,state){});
  }
}
