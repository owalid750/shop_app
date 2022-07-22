import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';

import 'package:shop_app/screens/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';

import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

//Change Visibility Of Password
  bool isObsecure = false;
  IconData suffix = Icons.remove_red_eye;
  obsecureText() {
    isObsecure = !isObsecure;
    suffix = isObsecure ? Icons.visibility_off_outlined : Icons.remove_red_eye;
    emit(RegisterObsecureTexteState());
  }

//
  late RegisterModel registerModel;
  void userRegister({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value?.data);
      // print(RegisterModel.status);
      // print(RegisterModel.message);
      // print(RegisterModel.data?.name);
      // print(RegisterModel.data?.token);

      emit(RegisterInSuccessState(registerModel));
    }).catchError((error) {
      print(" ERROR WHILE Register >> ${error.toString()}");
      emit(RegisterInErrorState(error.toString()));
    });
  }
//

}
