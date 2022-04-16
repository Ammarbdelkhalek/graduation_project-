import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/modules/register/cubit/cubit.dart';
import 'package:realestateapp/modules/register/cubit/states.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';

import '../../shared/components/headerwidget.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) => {
                  navigateAndFinish(
                    context,
                    LayoutScreen(),
                  )
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      child: Stack(children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: const HeaderWidget(
                          150, false, Icons.person_add_alt_1_rounded),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      child: Column(children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 80, 0, 0),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Colors.grey.shade700,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your name';
                                  }
                                },
                                label: 'Name',
                                prefix: Icons.person,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Email Address';
                                  }
                                },
                                label: 'Email Address',
                                prefix: Icons.email,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                  isPassword:
                                      RegisterCubit.get(context).isPassword,
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Password';
                                    }
                                  },
                                  label: 'Password',
                                  prefix: Icons.lock,
                                  suffix: RegisterCubit.get(context).suffix,
                                  suffixpressed: () {
                                    RegisterCubit.get(context)
                                        .ChangePasswordVisibility();
                                  }),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Phone';
                                  }
                                },
                                label: 'Phone',
                                prefix: Icons.phone,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Register',
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]))));
        },
      ),
    );
  }
}
