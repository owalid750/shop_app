import 'package:shop_app/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterObsecureTexteState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterInSuccessState extends RegisterStates {
  final RegisterModel registerModel;

  RegisterInSuccessState(this.registerModel);
}

class RegisterInErrorState extends RegisterStates {
  final String error;

  RegisterInErrorState(this.error);
}
