import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/setting/userprofile.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Ads_Details extends StatefulWidget {
  PostModel? model;

  Ads_Details({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Ads_Details> createState() => _Ads_DetailsState();
}

class _Ads_DetailsState extends State<Ads_Details> {
  UserModel? usermodel;

  var ADSController = PageController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppAddToFavoritesSuccessState) {
          showToast(
              text: 'favorite added successfully '.tr().toString(),
              state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;
        var postmodel = AppCubit.get(context).postModel;

        return Scaffold(
          appBar: AppBar(
            title: Text('Ads Details'.tr().toString()),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
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
                  builditems(widget.model!, usermodel!, context),
                               ],
              ),
            ]),
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
              Positioned(
                right: appPadding / 2,
                top: appPadding / 2,
                child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                          icon:const Icon(
                        Icons.favorite_rounded,
                                ),
                      onPressed: () {
                        AppCubit.get(context).addtofav(
                          model,


                        );

                     //  icon: AppCubit.get(context).favorites.length == 0
                     //      ? const Icon(
                     //          Icons.favorite_rounded,
                     //        )
                     // :  const Icon(
                     //    Icons.favorite_rounded,
                     //    color: Colors.red,
                     //  ),

                        // AppCubit.get(context).favorites.length == 0
                        //     ? AppCubit.get(context).addtofav(
                        //            model,
                        //     AppCubit.get(context).postsId[index]
                        //       )  //the errro cause of null index  should br solved
                        //     : showToast(
                        //         text: 'Aleardy Added'.tr().toString(),
                        //         state: ToastStates.WARNING);
                      },
                    )),
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
                  activeDotColor: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Report',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ))
            ],
          ),
          Row(children: [
            Text(
              ' Type '.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.type}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.king_bed_outlined,
            ),
            Text(
              ' Number of room'.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.no_of_room}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.bathtub_outlined,
            ),
            Text(
              ' Number of bathroom'.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.no_of_bathroom}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.space_bar_outlined,
            ),
            Text(
              ' Area'.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.area}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.house_outlined,
            ),
            const Text(
              ' Name',

            ),
            const Spacer(),
            Text(
              '${model.namePost}',
            ),
          ]),
          myDivider(),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Description'.tr().toString(),
                  maxLines: 6,
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
                  ),
                ),
              ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.gps_fixed_rounded,
            ),
            Text(
              ' location'.tr().toString(),
            ),
            Spacer(),
            Text(
              '${model.place}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.price_change_rounded,
            ),
            Text(
              ' Price'.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.price}',
            ),
          ]),
          myDivider(),
          Row(children: [
            const Icon(
              Icons.category_outlined,
            ),
            Text(
              ' Category Type '.tr().toString(),
            ),
            const Spacer(),
            Text(
              '${model.category}',
            ),
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    onPressed: () {
                      AppCubit.get(context).launchEmail(model.email);
                    },
                    child: Row(
                      children:  [
                        Icon(Icons.email),
                        Text(' Email'.tr().toString()) ,
                      ],
                    )),
                const SizedBox(
                  width: 5.0,
                ),
                MaterialButton(
                  onPressed: () {
                    AppCubit.get(context).whatsAppOpen(
                        model.phone!);
                  },
                  child: Row(
                    children:  [
                      Icon(Icons.whatsapp),
                      Text(' whatsapp'.tr().toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: (){
              launch(model.phone!);
            },
            child: const Icon(Icons.phone),
          ),

        ],
        )
    );


  }

}