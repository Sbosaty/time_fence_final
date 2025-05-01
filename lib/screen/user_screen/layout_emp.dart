
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/screen/auth_screen/login_screen.dart';
import 'package:time_fence/screen/user_screen/home_screen.dart';
import 'package:time_fence/screen/user_screen/services_emp_screen.dart';
import 'package:time_fence/screen/user_screen/setting_screen.dart';
import 'package:time_fence/unit/source.dart';

class LayoutEmp extends StatefulWidget {
  const LayoutEmp({super.key});

  @override
  State<LayoutEmp> createState() => _LayoutEmpState();
}

class _LayoutEmpState extends State<LayoutEmp> {

  final List<Widget> buildScreens=[
    const ServicesEmpScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit  = AppCubit.get(context);
          List<PersistentBottomNavBarItem> navBarsItems(BuildContext ctx){
            return [
              PersistentBottomNavBarItem(
                  icon: const Icon(Icons.electrical_services),
                  activeColorPrimary: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                  inactiveColorPrimary: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                  textStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12
                  )
              ),
              PersistentBottomNavBarItem(
                icon:  Container(
                  padding: const EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                    color: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                    shape: BoxShape.circle,
                  ),
                  child:  Center(child: Icon(Icons.home,
                    color: cubit.isDarkTheme ? ColorSource.blackColor: ColorSource.whiteColor,size: 20,)),
                ),
                textStyle: const TextStyle(
                    fontFamily: 'Poppins'
                ),
              ),
              PersistentBottomNavBarItem(
                  icon: const Icon(Icons.settings),
                  activeColorPrimary: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                  inactiveColorPrimary: cubit.isDarkTheme ? ColorSource.whiteColor: ColorSource.blackColor,
                  textStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12
                  )
              ),

            ];
          }
          return WillPopScope(
            onWillPop: ()async{
              return Navigator.canPop(context);
            },
            child: Scaffold(
              backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
              body: PersistentTabView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                context,
                controller: cubit.persistentTabController,
                screens: buildScreens,
                items: navBarsItems(context),
                onItemSelected: (int val){},
                backgroundColor: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                stateManagement: true,
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: cubit.isDarkTheme ? ColorSource.backgroundColorDark: ColorSource.backgroundColorLight,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0XFF868686).withOpacity(0.25),
                      blurRadius: 10,
                    ),
                  ],
                ),
                navBarHeight: 60,
                hideNavigationBarWhenKeyboardAppears: true,
                hideOnScrollSettings: const HideOnScrollSettings(
                    hideNavBarOnScroll: false
                ),
                navBarStyle: NavBarStyle.style1,
              ),
            ),
          );
        },
    listener: (context,state){
      if(state is LogoutState){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
          return LoginScreen();
        }), (_)=>false);
      }
    },);
  }
}
