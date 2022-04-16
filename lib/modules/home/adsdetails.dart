import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/chat/chatdetails.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/setting/userprofile.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Ads_Details extends StatelessWidget {
  PostModel? model;
  Ads_Details({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;

        return Scaffold(
          appBar: AppBar(
            title: Text('ads details'),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  builditems(model!, usermodel!, context),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            onPressed: () {
                              var index;
                              navigateTo(
                                  context,
                                  ChatDetailsScreen(
                                    userModel:
                                        AppCubit.get(context).users[index],
                                  ));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.chat),
                                Text('chat now '),
                              ],
                            )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            AppCubit.get(context).whatsAppOpen(
                                AppCubit.get(context).userModel!.phone!);
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.whatsapp),
                              Text('whats app')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              launch(usermodel.phone!);
            },
            child: const Icon(Icons.phone),
          ),
        );
      },
    );
  }

  Widget builditems(
    PostModel model,
    UserModel userModel,
    context,
  ) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Image(
            image: NetworkImage('${model.postImage}'),
            fit: BoxFit.cover,
          ),
          Row(children: [
            const Icon(
              Icons.king_bed_outlined,
              color: Colors.black,
            ),
            const Text(
              ' number of room',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              '${model.no_of_room}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.bathtub_outlined,
              color: Colors.black,
            ),
            const Text(
              ' number of bathroom',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              '${model.no_of_bathroom}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.king_bed_outlined,
              color: Colors.black,
            ),
            const Text(
              ' area',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              '${model.area}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.house_outlined,
              color: Colors.black,
            ),
            const Text(
              ' name',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              '${model.namePost}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.description_outlined,
              color: Colors.black,
            ),
            const Text(
              ' description',
              maxLines: 6,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              '${model.description}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.gps_fixed_rounded,
              color: Colors.black,
            ),
            const Text(
              ' location',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              '${model.place}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.price_change_rounded,
              color: Colors.black,
            ),
            const Text(
              'the price',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              '${model.price}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.category_outlined,
              color: Colors.black,
            ),
            const Text(
              ' category type ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              '${model.category}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ]),
          InkWell(
              onTap: () {},
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.name}',
                            ),
                            const Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.blue,
                            ),
                          ]),
                    ]))
              ]))
        ]));
  }
}
