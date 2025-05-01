
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/admin_screen/admin/add_admins_screen.dart';
import 'package:time_fence/screen/admin_screen/admin/edit_admin_screen.dart';
import 'package:time_fence/unit/source.dart';

class AllAdminsScreen extends StatefulWidget {
  const AllAdminsScreen({super.key});

  @override
  State<AllAdminsScreen> createState() => _AllAdminsScreenState();
}

class _AllAdminsScreenState extends State<AllAdminsScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllAdmins();
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
          title: const Text('All Mangers'),
          actions: [
            const SizedBox(width: 10,),
            IconButton(
              icon:  Icon(Icons.add,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const AddAdminsScreen();
                }));
              },
            ),
            const SizedBox(width: 10,),
          ],
        ),
        body: (state is LoadingGetAllUser)?
        const Center(child:CircularProgressIndicator()):

        ListView.builder(
          padding: const EdgeInsets.all(15),
            itemCount: cubit.adminList.length,
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
                      Text('Name : ${cubit.adminList[index].name??''}',
                      style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                      const SizedBox(height: 10,),
                      Text('Phone : ${cubit.adminList[index].phone??''}',
                        style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),
                      const SizedBox(height: 10,),
                      Text('Password : ${cubit.adminList[index].password??''}',
                        style:  TextStyle(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,fontSize: 16),),

                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return  EditAdmanScreen(
                        userModel: cubit.adminList[index],
                      );
                    }));
                  }, child: const Icon(Icons.edit,color: ColorSource.pColor,size: 25,))
              ],
            ),
          );
        }),
      );
    });
  }
}
