import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('selectced images '),
            leading: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  AppCubit.get(context).getImages();
                },
                child: const Icon(Icons.image),
              ),
              const SizedBox(
                height: 20.0,
              ),
              AppCubit.get(context).addImages == null
                  ? Text('no image selected ')
                  : MaterialButton(
                      onPressed: () {
                        //     AppCubit.get(context).uploadpostandimage();
                      },
                      child: Text('upload images '),
                    ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: AppCubit.get(context).addImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(AppCubit.get(context).addImages[index].path),
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
