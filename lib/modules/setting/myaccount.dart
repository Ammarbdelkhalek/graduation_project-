import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/setting/bundle.dart';
import 'package:realestateapp/modules/setting/setting_screen.dart';
import 'package:realestateapp/modules/setting/userprofile.dart';
import '../../shared/components/components.dart';

class useraccount extends StatefulWidget {
  useraccount({Key? key}) : super(key: key);

  @override
  State<useraccount> createState() => _useraccountState();
}

class _useraccountState extends State<useraccount> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, states) {
        int index;
        var userModel = AppCubit.get(context).userModel;
        AppCubit cubit = AppCubit.get(context);
        bool dark = false;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${userModel!.image}'),
                        maxRadius: 55,
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        '${userModel.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'MY ACCOUNT'.tr().toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(
                        context, User_Profile(AppCubit.get(context).posts[0]));
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.adf_scanner,
                          color: Colors.green,
                        ),
                        Text(
                          'your ads '.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {
                    navigateTo(context, Oubundle());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                        ),
                        Text(
                          'bundles'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {
                    navigateTo(context, profilesetting());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          color: Colors.green,
                        ),
                        Text(
                          'Profile'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'SETTINGS'.tr().toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.green,
                        ),

                        Text(
                          'Dark Mode'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        Switch(
                          value: dark,
                          onChanged: (newValue) {
                            setState(() {
                              newValue = dark;
                            });
                            AppCubit.get(context).changeAppMode();
                          },
                        ),
                        // separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          'Country'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        Text('Egypt'.tr().toString()),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (context) => Container(
                                height: 170,
                                child: Column(children: <Widget>[
                                  ListTile(
                                    leading: const Icon(
                                      Icons.abc_sharp,
                                    ),
                                    title: Text('English'.tr().toString()),
                                    onTap: () {
                                      context.setLocale(Locale('en', 'US'));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.language,
                                    ),
                                    title: const Text('arabic'),
                                    onTap: () {
                                      context.setLocale(Locale('ar', 'EG'));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ])));
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.flag_outlined,
                            color: Colors.green,
                          ),
                          Text(
                            'Language'.tr().toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Spacer(),
                          Text('English'.tr().toString()),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'REACH OUT TO US'.tr().toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          'FAQs'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          'Contact Us'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context).currentIndex = 0;
                      AppCubit.get(context).signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.power_settings_new),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SignOut'.tr().toString(),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
