

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/model/user_model.dart';
import 'package:time_fence/unit/source.dart';

class AddSalaryScreen extends StatefulWidget {
  final UserModel userModel;
  const AddSalaryScreen({super.key, required this.userModel});

  @override
  State<AddSalaryScreen> createState() => _AddSalaryScreenState();
}

class _AddSalaryScreenState extends State<AddSalaryScreen> {

  var formKey=GlobalKey<FormState>();
  var manController=TextEditingController();
  var moneyController=TextEditingController();
  var descController=TextEditingController();

  String ? salaryType;
  List<String> salaryTypeList =['Advance','Adjustment','Bonuses'];

  @override
  void initState() {
    moneyController.text = (widget.userModel.salary??0.0).toString();
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
              backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
              foregroundColor:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
              title: const Text('Add Salary'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: ()async{
                          showDatePicker(context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),).then((val){
                                if(val!=null){
                                  manController.text= val.month.toString();
                                }
                          });
                        },
                        child: TextFormField(
                          controller: manController,
                          enabled: false,
                          style:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Date',
                            hintText: 'Date',
                            hintStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            labelStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            prefixIcon:  Icon(Icons.calendar_month_outlined,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                              return 'Please Enter The Date';
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        keyboardType:TextInputType.number ,
                        controller: moneyController,
                        style:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Salary',
                          hintText: 'Salary',
                          hintStyle:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          labelStyle:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          prefixIcon:  Icon(FontAwesomeIcons.moneyBills,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                            return 'Please Enter The Salary';
                          }
                        },
                      ),

                      const SizedBox(height: 15,),


                      DropdownButtonFormField(
                        hint:  Text('Salary type',style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        )),
                        style:  TextStyle(
                          color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        items: [
                          ...salaryTypeList.map((e){
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e,style: const TextStyle(
                                  color: ColorSource.pColor
                              ),),
                            );
                          })
                        ],
                        value: salaryType,
                        onChanged: (val){
                          salaryType =val;
                        },
                        decoration: InputDecoration(
                          prefixIcon:  Icon(Icons.category_rounded,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: ColorSource.pColor,width: 5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                          ),
                        ),
                        validator: (val){
                          if(val==null){
                            return 'Please Enter The Salary type';

                          }
                        },
                      ),

                      const SizedBox(height: 15,),



                      TextFormField(
                        keyboardType:TextInputType.text ,
                        controller: descController,
                        maxLines: 6,
                        style:  TextStyle(
                            color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Reason for request',
                          hintStyle:  TextStyle(
                              color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
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

                      ),

                      const SizedBox(height: 25,),
                      (state is! LoadingSignUpScreen)?
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            cubit.addSalary(
                              uIdUser: widget.userModel.uId??'',
                              salaryType: salaryType!,
                              date: manController.text,
                              dis: descController.text.isNotEmpty?descController.text:'',
                              salary: double.parse(moneyController.text),
                            );
                          }
                        },
                        minWidth: double.infinity,
                        color: ColorSource.pColor,
                        textColor: Colors.white,
                        height: 50,
                        child:  const Text('Add Salary',style: TextStyle(
                            fontSize: 20
                        ),),
                      ):
                      const Center(child:CircularProgressIndicator()),

                    ],
                  ),
                ),
              ),
            ),

          );
        }, listener: (context,state){
      if (state is ErrorSignUpScreen){
        Fluttertoast.showToast(
          msg: 'Check in information',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }else if (state is SuccessSignUpScreen){
        Navigator.pop(context);
        BlocProvider.of<AppCubit>(context).getSalary(uid: widget.userModel.uId??'');
      }
    });
  }
}
