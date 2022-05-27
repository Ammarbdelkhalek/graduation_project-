import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/components/components.dart';

class drawer_setting extends StatefulWidget {
  const drawer_setting({Key? key}) : super(key: key);

  @override
  State<drawer_setting> createState() => _drawer_settingState();
}

class _drawer_settingState extends State<drawer_setting> {
  UserModel? model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          model = AppCubit.get(context).userModel;
          return Container(
              color: Colors.brown,
              child: Padding(
                padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${model!.image}'),
                        maxRadius: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' ${model!.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' ${model!.email}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            const Icon(
                              Icons.description,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              onPressed: () {
                                //   navigateTo(context, );
                              },
                              child: const Text(
                                'All Posts',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        BuildDrawer(
                          icon: Icons.error_outline,
                          text: 'Settings',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BuildDrawer(
                          icon: Icons.error_outline,
                          text: 'Settings',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BuildDrawer(
                          icon: Icons.error_outline,
                          text: 'Settings',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BuildDrawer(
                          icon: Icons.error_outline,
                          text: 'Settings',
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}

class BuildDrawer extends StatelessWidget {
  final IconData icon;
  final String text;

  const BuildDrawer({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
