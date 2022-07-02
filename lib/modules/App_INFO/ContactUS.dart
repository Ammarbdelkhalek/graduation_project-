import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/styles/colors.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppCreateContactUsSuccessState) {
            showToast(
                text: 'successfully'.tr().toString(),
                state: ToastStates.SUCCESS);
            navigateAndFinish(context, LayoutScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Contact Us'),
              titleSpacing: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is AppCreatePostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is AppCreatePostLoadingState)
                      const SizedBox(
                        height: 10,
                      ),
                    Container(
                      color: Colors.grey[500],
                      child: const Image(image: AssetImage('assets/images/12.png'),
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Name'.tr()
                                .toString();
                          }
                        },
                        label: 'Name'.tr().toString(),
                        prefix: Icons.person_outline,
                        labelStyle: TextStyle(
                          color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                        ),
                        color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Email'.tr()
                                .toString();
                          }
                        },
                        label: 'Email'.tr().toString(),
                        prefix: Icons.mail_outline,
                        labelStyle: TextStyle(
                          color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                        ),
                        color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: defaultFormField(
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Phone'.tr()
                                .toString();
                          }
                        },
                        label: 'Phone'.tr().toString(),
                        prefix: Icons.phone,
                        labelStyle: TextStyle(
                          color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                        ),
                        color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your problem' ;
                          }
                        },
                        controller: problemController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          //focusColor: Colors.greenAccent,
                          hintText: 'How can we help you ?'.tr().toString(),
                          hintStyle: TextStyle(
                            color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(width: 3, color: Colors.greenAccent),

                          ),
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 3, color: defaultColor),borderRadius: BorderRadius.circular(30),),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 3, color: defaultColor),borderRadius: BorderRadius.circular(30),),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).CreateContactUs(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            problem: problemController.text,
                          );
                        }
                      },
                      child: Text(
                        'Send'.tr().toString(),
                        style:TextStyle(color: Colors.greenAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}