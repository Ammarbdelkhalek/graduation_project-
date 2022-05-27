import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/login/cubit/cubit.dart';
import 'package:realestateapp/modules/login/cubit/states.dart';
import 'package:realestateapp/modules/login/login_screen.dart';

import '../../shared/components/components.dart';

class Forgetpassword extends StatelessWidget {
  Forgetpassword({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            showToast(
              text: 'the Email sent ',
              state: ToastStates.SUCCESS,
            );
            navigateTo(context, LoginScreen());
          }
          if (state is ForgetPasswordErrorState) {
            showToast(
              text: 'the Email is not valied  ',
              state: ToastStates.ERROR,
            );
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('forget password'),
              leading: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 310,
                  height: 500,
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Forget Your Password ?',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Text(
                        'confirm  your mail to know the instruction',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      ConditionalBuilder(
                          condition: state is! ForgetPasswordLoadingState,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context)
                                      .RestPassword(emailController.text);
                                }
                              },
                              text: 'reset password',
                            );
                          },
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
