
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/auth_screen/login_screen.dart';
import 'package:time_fence/unit/source.dart';
import '../card_user.dart';
import '../timer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getLocation();
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
          title: const Text('Home'),
          foregroundColor: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
          backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
        ),
        body:   SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const EmployeeIDCard(),
              const SizedBox(height: 20,),
              (state is LoadingGetLocation)?
              const Center(child: CircularProgressIndicator()):const AddTimeLogCard()
            ],
          ),
        ),
      );
    }, listener: (context,state){
          if(state is LogoutState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return LoginScreen();
            }), (_)=>false);
          }
        });
  }
}
