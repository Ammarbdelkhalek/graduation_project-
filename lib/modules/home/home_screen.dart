import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:realestateapp/models/category_model.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/category/CateegoryAds.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/modules/new_post/new_post.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? usermodel;
  PageController AdsImages = PageController();


  // void chatwithOwner(context) {
  //   if (AppCubit.get(context).users == usermodel!.uid) {
  //     for (var i = 0; i > AppCubit.get(context).users.length; i++) {
  //       print(AppCubit.get(context).users[i]);
  //       navigateTo(context,
  //           ChatDetailsScreen(userModel: AppCubit.get(context).users[i]));
  //
  //       print('=================================');
  //       print('successs');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppAddToFavoritesSuccessState) {
        showToast(
            text: 'favorite added successfully '.tr().toString(),
            state: ToastStates.SUCCESS);
      }
    }, builder: (context, state) {
      return Scaffold(

        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    child: CarouselSlider(
                      items: carouselSliderImages,
                      options: CarouselOptions(
                        height: 250,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        viewportFraction: 0.9,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ConditionalBuilder(
                      condition: AppCubit.get(context).categories.length > 0,
                      builder: (context) {
                        return Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: 100.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: (() {
                                      navigateTo(
                                          context,
                                          rentcategory(AppCubit.get(context)
                                              .categories[index]));
                                    }),
                                    child: BuildCategoryItems(
                                        AppCubit.get(context)
                                            .categories[index]),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 5.0,
                                  ),
                                  itemCount:
                                      AppCubit.get(context).categories.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator())),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Most Recent Ads ".tr().toString(),
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ConditionalBuilder(
                    condition: AppCubit.get(context).posts.length > 0 &&
                        AppCubit.get(context).userModel != null,
                    builder: (context) => Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                              onTap: (() {
                                navigateTo(
                                    context,
                                    Ads_Details(
                                        model: AppCubit.get(context)
                                            .posts[index]));
                              }),
                              child: BuildPost(
                                  AppCubit.get(context).posts[index],
                                  context,
                                  index)),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: AppCubit.get(context).posts.length,
                        ),
                      ],
                    ),
                    fallback: (context) =>
                        AppCubit.get(context).posts.length == 0
                            ? Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://correspondentsoftheworld.com/images/elements/clear/undraw_Content_structure_re_ebkv_clear.png'),
                                      height: 300,
                                      width: 380,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      ' You Have No Posts  '.tr().toString(),
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ]),
          ),
        ),
      );
    });
  }

  Widget BuildCategoryItems(CategoryDataModel? categoryDataModel) {
    return Padding(
        padding: const EdgeInsets.only(right: appPadding / 3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage('${categoryDataModel!.categoryImage}'),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                '${categoryDataModel.categoryName}',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ));
  }

  Widget BuildPost(PostModel model, context, index) {
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
                          controller: AdsImages,
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
                              color: white, borderRadius: BorderRadius.circular(15)),
                          child: IconButton(
                          // icon: AppCubit.get(context).favorites.length == 0
                            //     ? const Icon(
                            //   Icons.favorite_rounded,
                            // )
                            //     :  const Icon(
                            //   Icons.favorite_rounded,
                            //   color: Colors.red,
                            // ),
                            onPressed: () {
                              AppCubit.get(context).addtofav(
                                      AppCubit.get(context).posts[index],
                                      AppCubit.get(context).postsId[index],

                                   ) ;                            // AppCubit.get(context).favorites.length == 0
                              //     ? AppCubit.get(context).addtofav(
                              //     AppCubit.get(context).posts[index],
                              //     AppCubit.get(context).postsId[index],
                              // )
                              // //the errro cause of null index  should br solved
                              //     : showToast(
                              //     text: 'Aleardy Added'.tr().toString(),
                              //     state: ToastStates.WARNING);
                            }, icon: const Icon(
                               Icons.favorite_rounded,
                             )
                          )),
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
                    Text(
                      '${model.place}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15, color: black.withOpacity(0.4)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${model.no_of_room} Bedrooms / ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${model.no_of_bathroom} Bathrooms / ',
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

 
