import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/login/cubit/cubit.dart';
import 'package:realestateapp/modules/login/cubit/states.dart';
import 'package:realestateapp/modules/login/forgetpassword.dart';
import 'package:realestateapp/modules/register/register_screen.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';

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
                  // AppCubit.get(context).getfaviourite(),
                  AppCubit.get(context).getUserAds(),
                  AppCubit.get(context).getUserData(),
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const Image(
                  image:
                  AssetImage('assets/images/login.jpg'),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: 310,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54.withOpacity(0.4),
                  ),
                  //     decoration: BoxDecoration(backgroundBlendMode: BlendMode.darken),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            const Text(
                              'Login now to buy or rent any real estste easily',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black45),
                              child: defaultFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Email Address';
                                  }
                                  String pattern = r'\w+@\w+\.\w+';
                                  if (!RegExp(pattern).hasMatch(value)) {
                                    return 'invalid email address format';
                                  }
                                },
                                label: 'Email Address',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                prefix: Icons.email,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black45,
                              ),
                              child: defaultFormField(
                                  style: const TextStyle(color: Colors.white),
                                  isPassword:
                                      LoginCubit.get(context).isPassword,
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Password';
                                    }
                                    // String pattern =
                                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                    // if (!RegExp(pattern).hasMatch(value)) {
                                    //   return 'invalid password format';
                                    // }
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
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  prefix: Icons.lock,
                                  color: Colors.white,
                                  suffix: LoginCubit.get(context).suffix,
                                  suffixpressed: () {
                                    LoginCubit.get(context)
                                        .ChangePasswordVisibility();
                                  }),
                            ),
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
                                const Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(
                                      context,
                                      RegisterScreen(),
                                    );
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'do you forget password?? ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, Forgetpassword());
                                  },
                                  child: const Text(
                                    'forget password',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
