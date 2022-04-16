import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/login/cubit/cubit.dart';
import 'package:realestateapp/modules/login/cubit/states.dart';
import 'package:realestateapp/modules/register/register_screen.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';

import '../../shared/components/headerwidget.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  double _headerHeight = 210;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) => {
                  uid = state.uid,
                  navigateAndFinish(
                    context,
                    LayoutScreen(),
                  ),
                  AppCubit.get(context).getfaviourite(),
                  AppCubit.get(context).getUserAds(),
                  AppCubit.get(context).getUserData(),
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: _headerHeight,
                          width: double.infinity,
                          child: HeaderWidget(
                              _headerHeight,
                              true,
                              Icons
                                  .login_rounded), //let's create a common header widget
                        ),
                        SafeArea(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: const EdgeInsets.fromLTRB(
                                15, 5, 5, 10), // This will be the login form
                            child: Column(
                              children: [
                                const Text(
                                  'Hello',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Signin into your account',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 30.0),
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
                                  height: 30.0,
                                ),
                                defaultFormField(
                                    isPassword:
                                        LoginCubit.get(context).isPassword,
                                    controller: passwordController,
                                    type: TextInputType.visiblePassword,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                    },
                                    onSubmit: (value) {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    label: 'Password',
                                    prefix: Icons.lock,
                                    suffix: LoginCubit.get(context).suffix,
                                    suffixpressed: () {
                                      LoginCubit.get(context)
                                          .ChangePasswordVisibility();
                                    }),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: 'Login',
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account ?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!,
                                    ),
                                    defaultTextButton(
                                      function: () {
                                        navigateTo(
                                          context,
                                          RegisterScreen(),
                                        );
                                      },
                                      text: 'Register',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
