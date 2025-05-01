

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class EmptyScreen extends StatelessWidget {
  final bool isTasks;
  const EmptyScreen({super.key, required this.isTasks});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            appBar: AppBar(
              title: Text(isTasks?'Tasks':'Announcements'),
              foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity,),
                SvgPicture.asset('assets/image/empty-box.svg',
                  fit: BoxFit.fill,
                  height: 200,width: 200,),
                const SizedBox(height: 15,),
                Text(isTasks? 'No Tasks Found': 'No Announcement Found',
                style: TextStyle(
                  color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),),

              ],
            )

          );
        });
  }
}
