import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layout/cubit/cubit.dart';

Widget defaulttextForm({
  String? hinttext,
  Text? label,
  Widget? icon,
  InputBorder? border,
  var validator,
  var onchange,
  bool securetext = false,
  TextEditingController? controller,
  Key? key,
  Widget? suffix,
  Widget? prefix,

  var onsubmit,
}) =>
    TextFormField(
      
      onChanged: onchange,
      key: key,
      onFieldSubmitted: onsubmit,
      controller: controller,
      validator: validator,
      obscureText: securetext,
      decoration: InputDecoration(
        prefixIcon: prefix,
        hintText: hinttext,
        border: border,
        // suffix:suffix,
        suffixIcon: suffix,
        // prefixIcon: Icon(Icons.email),
        label: label,
        // prefix: Icon(Icons.email),
        icon: icon,
      ),
    );

void navigateTO(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, Widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Widget));

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERRROR, WARNING }

Color changeToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERRROR:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.yellow;
  }
}


