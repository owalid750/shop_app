import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/screens/login/cubit/cubit.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import 'package:shop_app/screens/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/constance.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passowrdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) {
          return LoginCubit();
        },
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginInSuccessState) {
              if (state.loginModel.status == true) {
                // print(state.loginModel.status);

                // print(state.loginModel.data?.token);
                CacheHelper.saveDate(
                        key: "token", value: state.loginModel.data?.token)
                    ?.then((value) {
                  token = state.loginModel.data?.token!;
                  navigateAndFinish(context, HomeLayout());
                });
              } else {
                print(state.loginModel.message);
                showToast(
                    msg: '${state.loginModel.message}',
                    state: ToastStates.ERRROR);
              }
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            defaulttextForm(
                              controller: emailController,
                              border: OutlineInputBorder(),
                              hinttext: "Email",
                              icon: Icon(Icons.email),
                              label: Text("Plz Enter The Email"),
                              validator: (value) {
                                if (value == "" || value.isEmpty) {
                                  return "You Must Enter The Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaulttextForm(
                              controller: passowrdController,
                              suffix: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context).obsecureText();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffix)),
                              securetext:
                                  !LoginCubit.get(context).isObsecure == true
                                      ? true
                                      : false,
                              border: OutlineInputBorder(),
                              hinttext: "Passowrd",
                              onsubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passowrdController.text);
                                }
                              },
                              icon: Icon(Icons.password),
                              label: Text("Plz Enter The Passowrd"),
                              validator: (value) {
                                if (value == "" || value.isEmpty) {
                                  return "You Must Enter The Passowrd";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) {
                          return Container(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passowrdController.text);
                                    }
                                  },
                                  child: Text("LOGIN")));
                        },
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        children: [
                          Text("Don't have an account? "),
                          TextButton(
                              onPressed: () {
                                navigateTO(context, RegisterScreen());
                              },
                              child: Text("REGISTER"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
