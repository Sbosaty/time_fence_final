
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/admin_screen/home_admin.dart';
import 'package:time_fence/screen/admin_screen/layout_admin.dart';
import 'package:time_fence/screen/timer_card.dart';
import 'package:time_fence/screen/user_screen/home_screen.dart';
import 'package:time_fence/screen/auth_screen/register_screen.dart';
import 'package:time_fence/screen/user_screen/layout_emp.dart';
import 'package:time_fence/unit/source.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is SuccessGetUserScreen){
          if(BlocProvider.of<AppCubit>(context).userModel?.isActive??false){
            if((BlocProvider.of<AppCubit>(context).userModel?.typeAccount??'') == 'Emp'){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                return const LayoutEmp();
              }), (_)=>false);
            }else{
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                return const LayoutAdmin();
              }), (_)=>false);
            }
          }else{
            BlocProvider.of<AppCubit>(context).logout();
            Fluttertoast.showToast(
              msg: 'This account not active',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0,
            );
          }

        }
        else if (state is ErrorLoginScreen){
          Fluttertoast.showToast(
            msg: 'Check in email and password again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0,
          );
        }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor:cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),),
                        const SizedBox(height: 15,),
                        Text('Login now with Friends',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            )),
                        const SizedBox(height: 25,),

                        TextFormField(
                          keyboardType:TextInputType.emailAddress ,
                          controller: emailController,
                          style:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Email Address',
                            hintStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            labelStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            prefixIcon:  Icon(Icons.person,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                              return 'Please Enter The Correct The Email';
                            }
                          },
                        ),
                        const SizedBox(height: 15,),

                        TextFormField(
                          keyboardType:TextInputType.visiblePassword ,
                          controller: passwordController,
                          obscureText: cubit.obscureText,
                          style:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            hintStyle:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            labelStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            prefixIcon:  Icon(Icons.lock,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                            contentPadding:const  EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:  BorderSide(color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: ColorSource.pColor,width: 1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: ()=>cubit.visiblePassword(),
                              icon: Icon(cubit.obscureText?Icons.visibility:Icons.visibility_off,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please Password is Shorted';
                            }
                          },
                        ),



                        const SizedBox(height: 25,),
                        (state is! LoadingLoginScreen)?
                        MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          minWidth: double.infinity,
                          color: ColorSource.pColor,
                          textColor: Colors.white,
                          height: 50,
                          child:  const Text('Login',style: TextStyle(
                              fontSize: 20
                          ),),
                        ):
                        const Center(child:CircularProgressIndicator()),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                             Text('Don\'t have a account?',
                              style: TextStyle(fontSize: 16,
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),),
                            TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen())),
                                child: Text('Register'.toUpperCase(),style:const TextStyle(fontSize: 16)))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}


