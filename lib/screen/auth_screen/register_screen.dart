
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';


class RegisterScreen extends StatelessWidget {
RegisterScreen({super.key});

  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  var jopTitleController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is SuccessSignUpScreen){
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Information review',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 18.0,
          );
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
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.backgroundColorLight,
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign Up',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),),
                        const SizedBox(height: 15,),
                        Text('Sign Up now with Company',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            )),
                        const SizedBox(height: 25,),
                        TextFormField(
                          controller: nameController,
                          style:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Name',
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
                              return 'Please Enter The Name';
                            }
                          },
                        ),
                        const SizedBox(height: 15,),
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
                                color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            prefixIcon:  Icon(Icons.email,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                          keyboardType:TextInputType.phone ,
                          controller: phoneController,
                          style:  TextStyle(
                              color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Phone Number',
                            hintStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            labelStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            prefixIcon:  Icon(Icons.phone,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                              return 'Please Enter The Phone';
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
                              icon: Icon(cubit.obscureText?Icons.visibility:Icons.visibility_off,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor),
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please Password is Shorted';
                            }
                          },
                        ),

                        const SizedBox(height: 15,),

                        TextFormField(
                          controller: jopTitleController,
                          style:  TextStyle(
                              color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Jop Title',
                            hintText: 'Jop Title',
                            hintStyle:  TextStyle(
                                color:cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),
                            labelStyle:  TextStyle(
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                            ),

                            prefixIcon:  Icon(Icons.comment,color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,),
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
                              return 'Please Enter The Jop Title';
                            }
                          },
                        ),


                        const SizedBox(height: 25,),
                        (state is! LoadingSignUpScreen)?
                        MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.userSignUp(
                                jopTitle: jopTitleController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,);
                            }
                          },
                          minWidth: double.infinity,
                          color: ColorSource.pColor,
                          textColor: Colors.white,
                          height: 50,
                          child:  const Text('Create Account',style: TextStyle(
                              fontSize: 20
                          ),),
                        ):
                        const Center(child:CircularProgressIndicator()),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                             Text('Do have a account?',
                              style: TextStyle(fontSize: 16,
                                color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                              ),),
                            TextButton(onPressed: ()=>Navigator.pop(context),
                                child: Text('Login'.toUpperCase(),style:const TextStyle(fontSize: 16)))
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

