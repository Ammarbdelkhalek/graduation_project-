import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
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
                  color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
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
                  width: double.infinity,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'MY ACCOUNT'.tr().toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color:AppCubit.get(context).isDark? Colors.grey : Colors.white,
                        fontSize: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(
                        context, User_Profile(AppCubit.get(context).posts[0]));
                  },
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.adf_scanner,
                          color: Colors.greenAccent,
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
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, Oubundle());
                  },
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.greenAccent,
                        ),
                        Text(
                          'Bundles'.tr().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, profilesetting());
                  },
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          color: Colors.greenAccent,
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
                Container(
                    width: double.infinity,
                    color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'SETTINGS'.tr().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         color:AppCubit.get(context).isDark? Colors.grey : Colors.white,
                          fontSize: 15,
                      ),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.greenAccent,
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
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          color: Colors.greenAccent,
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
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
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
                            color: Colors.greenAccent,
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
                    width: double.infinity,
                    color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'REACH US'.tr().toString(),
                      style: TextStyle(
                          color: AppCubit.get(context).isDark? Colors.grey : Colors.white,
                          fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.greenAccent,
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
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.greenAccent,
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
                Container(
                  width: double.infinity,
                  height: 18,
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                ),
                Container(
                  color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
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
