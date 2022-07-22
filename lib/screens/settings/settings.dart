import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constance.dart';

class SettingsScrean extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<LayOutCubit, LayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: LayOutCubit.get(context).userModel != null,
          builder: (context) {
            var model = LayOutCubit.get(context).userModel;
            nameController.text = model.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is LayOutChangeProfileLoadingData)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        defaulttextForm(
                          controller: nameController,
                          label: Text("Name"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name must ";
                            }
                            return null;
                          },
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.person),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaulttextForm(
                          controller: emailController,
                          label: Text("Email"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email must ";
                            }
                            return null;
                          },
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaulttextForm(
                          controller: phoneController,
                          label: Text("Phone"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Phone must ";
                            }
                            return null;
                          },
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    LayOutCubit.get(context).updateProfileData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: Text("Update"))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  signOut(context);
                                },
                                child: Text("LOGOUT"))),
                      ],
                    )),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }
}
