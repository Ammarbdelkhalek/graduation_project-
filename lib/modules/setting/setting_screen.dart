import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/videoandphoneCall/videoCallScreen.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:easy_localization/easy_localization.dart';

class profilesetting extends StatelessWidget {
  profilesetting({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            title: Text('account setting '),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    if (state is UserUpdateLoadingState)
                      const SizedBox(
                        height: 5,
                      ),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundImage: profileImage == null
                                ? NetworkImage('${userModel.image}')
                                : FileImage(profileImage) as ImageProvider,
                            maxRadius: 70,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: Icon(Icons.camera_alt),
                              color: Colors.black,
                              iconSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: const Icon(Icons.phone),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.video_call),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your phone';
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              AppCubit.get(context).updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text);
                            },
                            child: Text(
                              'Upload Profile Data',
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (AppCubit.get(context).profileImage != null)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text);
                              },
                              child: Text(
                                'Upload Profile Image',
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
        );
      },
    );
  }
}
