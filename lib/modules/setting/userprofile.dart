import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/editPost/EditPost.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/shared/components/constant.dart';
import '../../shared/components/components.dart';
import 'package:easy_localization/easy_localization.dart';

class User_Profile extends StatelessWidget {
  User_Profile(this.postModel, {Key? key}) : super(key: key);
  PostModel? postModel;
  UserModel? userModel;
  PageController UserAdsImages = PageController();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUserAds();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AppCubit.get(context).userModel;

          return Scaffold(
              appBar: AppBar(
                title: Text('Your Ads'),
              ),
              body: ConditionalBuilder(
                condition: AppCubit.get(context).userposts.length > 0 &&
                    AppCubit.get(context).userModel != null,
                builder: (context) => Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              Ads_Details(
                                  model: AppCubit.get(context).posts[index]));
                        },
                        child: BuildPost(AppCubit.get(context).userposts[index],
                            context, index),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: AppCubit.get(context).userposts.length,
                    ),
                  ],
                ),
                fallback: (context) =>
                    AppCubit.get(context).userposts.length == 0
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
                                  'Discover New ',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
              ));
        });
  }

  Widget BuildPost(
    PostModel model,
    context,
    index,
  ) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: appPadding, vertical: appPadding / 2),
          child: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 400.0,
                        height: 200.0,
                        child: PageView.builder(
                          controller: UserAdsImages,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Image(
                            image: NetworkImage('${model.postImage![index]}'),
                            width: 400.0,
                            height: 100.0,
                          ),
                          itemCount: model.postImage!.length,
                        ),
                      ),
                    ),
                    Positioned(
                      right: appPadding / 2,
                      top: appPadding / 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                          ),
                          onPressed: () {
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
                                          Icons.edit,
                                        ),
                                        title: Text(
                                          'Edit',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              EditPost(
                                                postmodel: model,
                                              ));
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.delete,
                                        ),
                                        title: Text('Delete'),
                                        onTap: () {
                                          AppCubit.get(context).deletPost(
                                              AppCubit.get(context)
                                                  .postsId[index]);
                                          navigateTo(context, LayoutScreen());
                                          print('Deleted');
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.close,
                                        ),
                                        title: Text('Close'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ])));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${model.place}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        '${model.place}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, color: black.withOpacity(0.4)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${model.no_of_room} bedrooms / ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${model.no_of_bathroom} bathrooms / ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${model.area} sqft',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.price_check_rounded),
                    Text(
                      '${model.price} Eg',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
