import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';

class userLocation extends StatelessWidget {
  const userLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (AppCubit.get(context).services == false) {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: const Center(
              child: Text(
                'services denied ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            title: 'services',
          ).show();
        }
      },
      builder: (context, state) {
        AppCubit.get(context).getpermission(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('user location'),
            leading: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(),
        );
      },
    );
  }
}
