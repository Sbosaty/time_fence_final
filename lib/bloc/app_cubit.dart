
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/model/leave_model.dart';
import 'package:time_fence/model/salary_model.dart';
import 'package:time_fence/model/user_model.dart';
import 'package:time_fence/unit/shared_pref_services.dart';
import 'package:uuid/uuid.dart';


class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  final PersistentTabController persistentTabController =PersistentTabController(initialIndex: 1);

  void changeIndexLayout(int index){
    persistentTabController.jumpToTab(index);
    emit(AnyAppState());
  }

  bool obscureText=true;
  void userLogin({required String email, required String password,}){
    emit(LoadingLoginScreen());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).
    then((value){
      emit(SuccessLoginScreen());
      getDateUser();
    }).
    onError((error,_){
      emit(ErrorLoginScreen());
    });
  }
  void visiblePassword(){
    obscureText=!obscureText;
    emit(AnyAppState());
  }

  bool isDarkTheme = false;
  void checkStateDarkTheme(){
    isDarkTheme = SharedPreferencesServices.getDate(key: 'DarkTheme')??false;
    emit(ChangeThemeState());
  }

  void changeStateDarkTheme(){
    isDarkTheme = !isDarkTheme;
    SharedPreferencesServices.setDate(key: 'DarkTheme',value: isDarkTheme);
    emit(ChangeThemeState());
  }


  File ? fileImage ;
  void changeImage(File file){
    fileImage = file;
    emit(AnyAppState());
  }


  double allowedLatitude = 30.0789101;
  double allowedLongitude = 30.0789101;
  double allowedRadiusMeters = 0.5;
  void getLocation(){
    emit(LoadingGetLocation());
    FirebaseFirestore.instance.collection('Loction').doc('WCDH7EfIJWGmTavEBtBg')
        .get().then((value){
      allowedLatitude = double.parse(value.data()?['Lat']);
      allowedLongitude = double.parse(value.data()?['Long']);
      allowedRadiusMeters = double.parse(value.data()?['Radies']);
      emit(SuccessGetLocation());
      print(allowedLatitude);
      print(allowedLongitude);
      print(allowedRadiusMeters);
    }).onError((_,e){
      emit(ErrorGetLocation());
    });
  }

  void editLocation({required String lat , required String long , required String redies}){
    emit(LoadingSelectLocation());
    FirebaseFirestore.instance.collection('Loction').doc('WCDH7EfIJWGmTavEBtBg')
        .set({
      'Lat':lat,
      'Long':long,
      'Radies':redies,
    }).then((value){
      emit(SuccessSelectLocation());
    }).onError((_,e){
      emit(ErrorSelectLocation());
    });
  }

  void addHour({required int hour ,required int min}){
    double convertToDecimalHours= hour + (min / 60);
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).update({
      'CountHour':(convertToDecimalHours+(userModel?.countHour??0))
    }).then((value){
      getDateUser();
      emit(SuccessGetLocation());
    }).onError((_,error){
      emit(ErrorGetLocation());
    });
  }

  void userSignUp({required String email, required String password, required String name, required String phone,required String jopTitle ,}){
    emit(LoadingSignUpScreen());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
      UserModel model=UserModel(
          name: name, email: email, phone: phone, uId: value.user?.uid,
      password: password,isActive: false,salary: 0.0,jopTitle: jopTitle,
        typeAccount: 'Emp',countHour: 0
      );
      FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set(
          model.toMap()
      ).then((value){
        emit(SuccessSignUpScreen());
        logout();
      }).onError((error,_){
        emit(ErrorSignUpScreen());
      });
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }

  void addAdmin({required String email, required String password, required String name, required String phone,}){
    emit(LoadingSignUpScreen());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
      UserModel model=UserModel(
          name: name, email: email, phone: phone, uId: value.user?.uid,
          password: password,isActive: true,salary: 0.0,jopTitle: 'HR Manger',
          typeAccount: 'Admin',countHour: 0
      );
      FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set(
          model.toMap()
      ).then((value){
        emit(SuccessSignUpScreen());
        logout();
      }).onError((error,_){
        emit(ErrorSignUpScreen());
      });
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }

  void editAdmin({required String email, required String password, required String name, required String phone,required String uid}){
    emit(LoadingSignUpScreen());
    FirebaseFirestore.instance.collection('Users').doc(uid).update(
        {
          'Name': name,
          'Password':password,
          'Phone': phone,
          'Email':email,
        }
    ).then((value){
      emit(SuccessSignUpScreen());
      getAllAdmins();
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }

  void editUser({required String email, required String password, required String name, required String phone,required String uid,required String active,required String salary}){
    emit(LoadingSignUpScreen());
    FirebaseFirestore.instance.collection('Users').doc(uid).update(
        {
          'Name': name,
          'Password':password,
          'Phone': phone,
          'Email':email,
          'salary':salary,
          'IsActive':active=='Active',
        }
    ).then((value){
      emit(SuccessSignUpScreen());
      getAllEmp();
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }
  
  UserModel? userModel;
  void getDateUser(){
    emit(LoadingGetUserScreen());
    userModel=null;
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).
      get().
      then((value){
        userModel=UserModel.formJson(value.data()!);
        emit(SuccessGetUserScreen());
      }).onError((error,_){
        emit(ErrorGetUserScreen());
      });
    }
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }

  List<UserModel> adminList=[];
  void getAllAdmins(){
    emit(LoadingGetAllUser());
    adminList=[];
    FirebaseFirestore.instance.collection('Users').get().
    then((value){
      for (var element in value.docs) {
        UserModel? s = UserModel.formJson(element);
        if(s.uId != FirebaseAuth.instance.currentUser?.uid && s.typeAccount=='Admin'){
          adminList.add(UserModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser(error.toString()));
    });
  }

  List<UserModel> empList=[];
  void getAllEmp(){
    emit(LoadingGetAllUser());
    empList=[];
    FirebaseFirestore.instance.collection('Users').get().
    then((value){
      for (var element in value.docs) {
        UserModel? s = UserModel.formJson(element);
        if(s.typeAccount=='Emp'){
          empList.add(UserModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser(error.toString()));
    });
  }

  void addSalary({required String uIdUser, required String dis, required String date, required String salaryType,required double salary}){
    emit(LoadingSignUpScreen());
    String uuid = const Uuid().v4();
      SalaryModel model=SalaryModel(
          uid: uuid,
          date: date,
          dis:dis ,
          salaryType: salaryType,
          salary: salary,
          uIdUser: uIdUser,
      );
      FirebaseFirestore.instance.collection('Salary').doc(uuid).set(
          model.toMap()
      ).then((value){
        FirebaseFirestore.instance.collection('Users').doc(uIdUser).update({
          'CountHour':0
        }).then((val){
          emit(SuccessSignUpScreen());
        }).onError((error,_){
          emit(ErrorSignUpScreen());
        });
        emit(SuccessSignUpScreen());
      }).onError((error,_){
        emit(ErrorSignUpScreen());
      });
  }

  List<SalaryModel> salaryList=[];
  void getSalary({required String uid}){
    emit(LoadingGetAllUser());
    salaryList=[];
    FirebaseFirestore.instance.collection('Salary').get().
    then((value){
      for (var element in value.docs) {
        SalaryModel? s = SalaryModel.formJson(element);
        if(s.uIdUser==uid){
          salaryList.add(SalaryModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser(error.toString()));
    });
  }

  void deleteSalary({required String uid,required String uidUser}){
    emit(LoadingUpdateUser());
    FirebaseFirestore.instance.collection('Salary').doc(uid).delete().
    then((value){
      emit(SuccessUpdateUser());
    }).onError((error,_){
      emit(ErrorUpdateUser());
    });
    getSalary(uid: uidUser);
  }

  void addLeave({required String time, required String date, required String type,required String link , required String note}){
    emit(LoadingSignUpScreen());
    String uuid = const Uuid().v4();
    LeaveModel model=LeaveModel(
      uid: uuid,
      link: link,
      name: userModel?.name??'',
      note: note,
      phone: userModel?.phone??'',
      type: type,
      time: time,
      date: date,
      uIdUser: userModel?.uId??'',
    );
    FirebaseFirestore.instance.collection('Leave').doc(uuid).set(
        model.toMap()
    ).then((value){
      emit(SuccessSignUpScreen());
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }

  List<LeaveModel> leaveList=[];
  void getLeaves(){
    emit(LoadingGetAllUser());
    leaveList=[];
    FirebaseFirestore.instance.collection('Leave').get().
    then((value){
      for (var element in value.docs) {
        leaveList.add(LeaveModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser(error.toString()));
    });
  }






}