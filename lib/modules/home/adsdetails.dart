import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Ads_Details extends StatelessWidget {
  PostModel? model;
  Ads_Details({
    Key? key,
    required this.model,
  }) : super(key: key);
  var ADSController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;
        var postmodel = AppCubit.get(context).postModel;

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
                            onPressed: ({currentindex}) {
                              var index = 0;
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
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 300.0,
                child: PageView.builder(
                  controller: ADSController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Image(
                    image: NetworkImage('${model.postImage![index]}'),
                    width: double.infinity,
                    height: 120.0,
                  ),
                  itemCount: model.postImage!.length,
                ),
              ),
              SmoothPageIndicator(
                controller: ADSController,
                count: model.postImage!.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                  activeDotColor: Colors.lightBlue,
                ),
              ),
            ],
          ),
          Row(children: [
            const Icon(
              Icons.king_bed_outlined,
              color: Colors.black,
            ),
            Text(
              ' number of room'.tr().toString(),
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
            Text(
              ' number of bathroom'.tr().toString(),
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
            Text(
              ' area'.tr().toString(),
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
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' description'.tr().toString(),
                  maxLines: 6,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Container(
                  width: double.infinity,
                  height: 90.0,
                  child: Text(
                    '${model.description}',
                    maxLines: 15,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.gps_fixed_rounded,
              color: Colors.black,
            ),
            Text(
              ' location'.tr().toString(),
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
            Text(
              'the price'.tr().toString(),
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
            Text(
              ' category type '.tr().toString(),
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
        ]));
  }
}
