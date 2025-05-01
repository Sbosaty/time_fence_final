
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
      return Scaffold(
        backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const UserPage();
                        }));
                      },
                      child: Text('Profile',
                        style: TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            fontSize: 20
                        ),),
                    ),
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
              ),

            ],
          ),
        ),
      );
    }, listener: (context,state){});
  }
}


class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
      var cubit = AppCubit.get(context);
      return Scaffold(
        backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
        appBar: AppBar(
          foregroundColor: ColorSource.whiteColor,
          title:  Text('Profile',
            style: TextStyle(
              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
            ),),
          backgroundColor:cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: double.infinity,),
              const SizedBox(height: 30,),

              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorSource.whiteColor
                        ),
                        child: Center(
                          child: cubit.fileImage == null?SvgPicture.asset('assets/image/profile.svg',
                          fit: BoxFit.fill,):ClipOval(
                            child: Image.file(cubit.fileImage!,
                              height: 100,
                              width: 100,
                            fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: ()async{
                            XFile? xFile =await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 1080,maxHeight: 1080);
                            if(xFile != null){
                              cubit.changeImage(File(xFile.path));
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: ColorSource.pColor,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.edit,color: ColorSource.whiteColor,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10,),
              Center(
                child: Text(cubit.userModel?.name??'',
                  style: TextStyle(
                      color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              const SizedBox(height: 20,),

              Text('About',
                style: TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                ),),
              const SizedBox(height: 20,),
              Text('Email',
                style: TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),),
              const SizedBox(height: 5,),
              Text(cubit.userModel?.email??'',
                style: const TextStyle(
                    color: ColorSource.pColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),

              const SizedBox(height: 15,),
              Text('Phone',
                style: TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),),
              const SizedBox(height: 5,),
              Text(cubit.userModel?.phone??'',
                style:  TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),

              const SizedBox(height: 15,),
              Text('Jop Title',
                style: TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),),
              const SizedBox(height: 5,),
              Text(cubit.userModel?.jopTitle??'',
                style:  TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),

              const SizedBox(height: 15,),
              Text('Salary',
                style: TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),),
              const SizedBox(height: 5,),
              Text('${cubit.userModel?.salary??0.0} EGP',
                style:  TextStyle(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),)
            ],
          ),
        ),
      );
    });
  }
}



