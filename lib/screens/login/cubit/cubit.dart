import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

//
  bool isObsecure = false;
  IconData suffix = Icons.remove_red_eye;
  obsecureText() {
    isObsecure = !isObsecure;
    suffix = isObsecure ? Icons.visibility_off_outlined : Icons.remove_red_eye;
    emit(LoginObsecureTexteState());
  }

//
  late LoginModel loginModel;
  void userLogin({
    String? email,
    String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data?.name);
      // print(loginModel.data?.token);

      emit(LoginInSuccessState(loginModel));
    }).catchError((error) {
      print(" ERROR WHILE LOGIN >> ${error.toString()}");
      emit(LoginInErrorState(error.toString()));
    });
  }
//

}
