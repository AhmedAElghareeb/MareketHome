import 'package:market_home/views/auth/login/model.dart';

class LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final LoginModel loginModel;

  SuccessLoginState(this.loginModel);
}

class FailedLoginState extends LoginStates {
  final String error;

  FailedLoginState(this.error);
}

class ChangePassState extends LoginStates {}

class UserDataLoadingState extends LoginStates {}

class UserDataSuccessState extends LoginStates {}

class UserDataFailedState extends LoginStates {}

class UserUpdateDataLoadingState extends LoginStates {}

class UserUpdateDataSuccessState extends LoginStates {}

class UserUpdateDataFailedState extends LoginStates {}
