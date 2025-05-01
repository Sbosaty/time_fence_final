
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';

class LeaveRequestScreen extends StatelessWidget {
  final bool leaveRequest;
  const LeaveRequestScreen({super.key, required this.leaveRequest});

  @override
  Widget build(BuildContext context) {

    var formKey=GlobalKey<FormState>();
    var dateController=TextEditingController();
    var timeController=TextEditingController();
    var noteController=TextEditingController();
    var linkController=TextEditingController();


    return BlocConsumer<AppCubit,AppState>(builder: (context,state){
      var cubit = AppCubit.get(context);
      return Scaffold(
          backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
          appBar: AppBar(
            title: Text(leaveRequest?'Leave Request':'Ask for permission'),
            foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
            backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25,),
                    GestureDetector(
                      onTap: ()async{
                        if(leaveRequest){
                          showDateRangePicker(context: context,
                            firstDate: DateTime.now().add(const Duration(days: 2)),
                            lastDate: DateTime(2100),).then((val){
                            if(val!=null){
                              dateController.text= '${val.start.year}-${val.start.month}-${val.start.day} / ${val.end.year}-${val.end.month}-${val.end.day}';
                            }
                          });

                        }else{
                          showDatePicker(context: context,
                            firstDate: DateTime.now().add(const Duration(days: 2)),
                            lastDate: DateTime(2100),).then((val){
                            if(val!=null){
                              dateController.text= '${val.year}-${val.month}-${val.day}';
                            }
                          });
                        }
                      },
                      child: TextFormField(
                        controller: dateController,
                        enabled: false,
                        style: TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Date',
                          hintText: 'Date',
                          hintStyle:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          labelStyle:  TextStyle(
                              color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          prefixIcon: Icon(Icons.calendar_month_outlined,color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                          contentPadding:const  EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Date';
                          }
                        },
                      ),
                    ),



                    if(!leaveRequest)
                    Column(
                      children: [
                        const SizedBox(height: 15,),
                        GestureDetector(
                          onTap: ()async{
                            showTimePicker(context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((val){
                              if(val!=null){
                                timeController.text= '${val.hour}-${val.minute}';
                              }
                            });
                          },
                          child: TextFormField(
                            controller: timeController,
                            enabled: false,
                            style:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Time',
                              hintText: 'Time',
                              hintStyle: TextStyle(
                                  color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),
                              labelStyle: TextStyle(
                                  color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),
                              prefixIcon: Icon(Icons.timelapse,color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                              contentPadding:const  EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter The Time';
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: noteController,
                      style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                      ),
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        hintText: 'Note',
                        hintStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        labelStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        contentPadding:const  EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter The Note';
                        }
                      },
                    ),


                    const SizedBox(height: 15,),

                    /*GestureDetector(
                      onTap: ()async{
                        FileP

                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical:5),
                        decoration: BoxDecoration(
                            color: const Color(0xff252525),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.file_copy_outlined,color: Colors.white,size: 30,),
                            SizedBox(height: 10,),
                            Text('Add File',
                              style: TextStyle(color: Colors.white,fontSize: 16),),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),*/


                    const SizedBox(height: 15,),

                    TextFormField(
                      controller: linkController,
                      style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Link',
                        hintText: 'Link',
                        hintStyle:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        labelStyle: TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),

                        prefixIcon:  Icon(Icons.link,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                        contentPadding:const  EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter The Link';
                        }
                      },
                    ),

                    const SizedBox(height: 25,),
                    (state is LoadingSignUpScreen)?
                    const Center(child:CircularProgressIndicator())
                        : MaterialButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          cubit.addLeave(
                            type: leaveRequest?'leaveRequest':'askPermission',
                            date: dateController.text,
                            link: linkController.text,
                            note: noteController.text,
                            time: timeController.text.isEmpty?'':timeController.text,
                          );
                        }
                      },
                      minWidth: double.infinity,
                      color: ColorSource.pColor,
                      textColor: Colors.white,
                      height: 50,
                      child:  const Text('Add',style: TextStyle(
                          fontSize: 20
                      ),),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    }, listener: (context,state){
      if(state is SuccessSignUpScreen){
        Navigator.pop(context);
      }
      else if (state is ErrorSignUpScreen){
        Fluttertoast.showToast(
          msg: 'Check in information',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }

    });
  }
}
