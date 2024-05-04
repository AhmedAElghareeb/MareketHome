import 'package:market_home/views/login/model.dart';

class RegisterStates {}

class LoadingRegisterState extends RegisterStates {}
class SuccessRegisterState extends RegisterStates {
  final LoginModel loginModel;

  SuccessRegisterState(this.loginModel);
}
class FailedRegisterState extends RegisterStates
{
  final String err;

  FailedRegisterState(this.err);
}

class ChangePassState extends RegisterStates {}