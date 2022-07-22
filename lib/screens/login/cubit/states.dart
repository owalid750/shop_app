import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginObsecureTexteState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginInSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginInSuccessState(this.loginModel);
}

class LoginInErrorState extends LoginStates {
  final String error;

  LoginInErrorState(this.error);
}
