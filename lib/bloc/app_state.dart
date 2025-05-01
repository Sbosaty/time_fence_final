abstract class AppState {}

class InitialState extends AppState{}
class AnyAppState extends AppState{}
class LogoutState extends AppState{}
class ChangeThemeState extends AppState{}

class LoadingGetLocation extends AppState{}
class SuccessGetLocation extends AppState{}
class ErrorGetLocation extends AppState{}

class LoadingSelectLocation extends AppState{}
class SuccessSelectLocation extends AppState{}
class ErrorSelectLocation extends AppState{}

class LoadingLoginScreen extends AppState{}
class SuccessLoginScreen extends AppState{}
class ErrorLoginScreen extends AppState{}

class LoadingSignUpScreen extends AppState{}
class SuccessSignUpScreen extends AppState{}
class ErrorSignUpScreen extends AppState{}

class LoadingGetUserScreen extends AppState{}
class SuccessGetUserScreen extends AppState{}
class ErrorGetUserScreen extends AppState{}

class LoadingUpdateUser extends AppState{}
class SuccessUpdateUser extends AppState{}
class ErrorUpdateUser extends AppState{}

class LoadingGetAllUser extends AppState{}
class SuccessGetAllUser extends AppState{}
class ErrorGetAllUser extends AppState{
  final String error;
  ErrorGetAllUser(this.error);
}






