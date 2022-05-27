import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/BundleModel.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/components/constant.dart';

class Oubundle extends StatelessWidget {
  const Oubundle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('our Bundel'),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, states) {
            return ConditionalBuilder(
              condition: AppCubit.get(context).Bundel.length > 0,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => BuidBundelItems(
                    AppCubit.get(context).Bundel[index], context, index),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: AppCubit.get(context).Bundel.length,
              ),
              fallback: (BuildContext context) {
                return AppCubit.get(context).Bundel.length == 0
                    ? Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Image(
                              image: NetworkImage(
                                  'https://correspondentsoftheworld.com/images/elements/clear/undraw_Content_structure_re_ebkv_clear.png'),
                              height: 300,
                              width: 380,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              ' you have no posts  ',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            );
          }),
    );
  }

  Widget BuidBundelItems(
    BunndelModel? model,
    index,
    context,
  ) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      //  crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: appPadding / 3),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            width: 110,
            height: 100,
            // color: Colors.grey[300],

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(' ${model!.bundleName}  '),
                const SizedBox(width: 8.0),
                const Text(' duration  '),
                Text(' ${model.bundleDuration}  days '),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
