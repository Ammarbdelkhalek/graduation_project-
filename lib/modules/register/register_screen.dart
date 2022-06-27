import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/modules/login/login_screen.dart';
import 'package:realestateapp/modules/register/cubit/cubit.dart';
import 'package:realestateapp/modules/register/cubit/states.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/formvalidator.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';

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
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [

                const Image(
                  image: AssetImage('assets/images/login.jpg'),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: 310,
                  height: 550,
                  color: Colors.black54.withOpacity(0.5),
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
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Text(
                                'Register now to buy or rent any real estste easily',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black45,
                                ),
                                child: defaultFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: FormFieldValidate.fullNameValidator,
                                  label: 'full Name',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  prefix: Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black45,
                                ),
                                child: defaultFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: FormFieldValidate.emailValidator,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black45,
                                ),
                                child: defaultFormField(
                                    style: const TextStyle(color: Colors.white),
                                    isPassword:
                                        RegisterCubit.get(context).isPassword,
                                    controller: passwordController,
                                    type: TextInputType.visiblePassword,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                      String pattern =
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                      if (!RegExp(pattern).hasMatch(value)) {
                                        return 'invalid password format';
                                      }
                                    },
                                    label: 'Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    prefix: Icons.lock,
                                    color: Colors.white,
                                    suffix: RegisterCubit.get(context).suffix,
                                    suffixpressed: () {
                                      RegisterCubit.get(context)
                                          .ChangePasswordVisibility();
                                    }),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black45,
                                ),
                                child: defaultFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: FormFieldValidate.phoneValidator,
                                  label: 'Phone',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  prefix: Icons.phone,
                                  color: Colors.white,
                                ),
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      navigateTo(context, LoginScreen());
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
