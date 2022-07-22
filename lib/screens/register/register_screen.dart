import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/register/cubit/cubit.dart';
import 'package:shop_app/screens/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../layout/home_layout.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passowrdController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterInSuccessState) {
            if (state.registerModel.status == true) {
              // print(state.RegisterModel.status);

              // print(state.RegisterModel.data?.token);
              CacheHelper.saveDate(
                      key: "token", value: state.registerModel.data?.token)
                  ?.then((value) {
                token = state.registerModel.data!.token!;
                navigateAndFinish(context, LoginScreen());
              });
            } else {
              print(state.registerModel.message);
              showToast(
                  msg: '${state.registerModel.message}',
                  state: ToastStates.ERRROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "REGISTER",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: formkey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          defaulttextForm(
                              icon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              hinttext: "Name",
                              controller: nameController,
                              validator: (value) {
                                if (value == "" || value.isEmpty) {
                                  return "Plz Enter Your Name";
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaulttextForm(
                            icon: Icon(Icons.phone_android),
                            border: OutlineInputBorder(),
                            hinttext: "Phone Number",
                            controller: phoneNumberController,
                            validator: (value) {
                              if (value == "" || value.isEmpty) {
                                return "You Must Enter The Phone Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaulttextForm(
                              border: OutlineInputBorder(),
                              hinttext: "Email",
                              icon: Icon(Icons.email),
                              controller: emailController,
                              validator: (value) {
                                if (value == "" || value.isEmpty) {
                                  return "Plz Enter Your Email";
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaulttextForm(
                            controller: passowrdController,
                            suffix: IconButton(
                                onPressed: () {
                                  RegisterCubit.get(context).obsecureText();
                                },
                                icon: Icon(RegisterCubit.get(context).suffix)),
                            securetext:
                                !RegisterCubit.get(context).isObsecure == true
                                    ? true
                                    : false,
                            border: OutlineInputBorder(),
                            hinttext: "Passowrd",
                            onsubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneNumberController.text,
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
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) {
                              return Container(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          
                                          RegisterCubit.get(context)
                                              .userRegister(
                                                  name: nameController.text,
                                                  phone: phoneNumberController
                                                      .text,
                                                  email: emailController.text,
                                                  password:
                                                      passowrdController.text);
                                        }
                                      },
                                      child: Text("Sign Up")));
                            },
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            children: [
                              Text("Already have an account? "),
                              TextButton(
                                  onPressed: () {
                                    navigateTO(context, LoginScreen());
                                  },
                                  child: Text("Login"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
