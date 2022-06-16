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
import 'package:realestateapp/modules/category/rentcategory.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';

import 'package:realestateapp/modules/new_post/new_post.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  PageController AdsImages = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppAddToFavoritesSuccessState) {
        showToast(
            text: 'faviourite added successfuly '.tr().toString(),
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
                  SizedBox(
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
                  Text(
                    "most recent ads ".tr().toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic),
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
                                      ' you have no posts  '.tr().toString(),
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
        padding: EdgeInsets.only(right: appPadding / 3),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
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
          padding: EdgeInsets.symmetric(
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
                            color: white,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                          icon: AppCubit.get(context).favorites.length == 0
                              ? const Icon(
                                  Icons.favorite_rounded,
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                ),
                          onPressed: () {
                            AppCubit.get(context).favorites.length == 0
                                ? AppCubit.get(context).addtofav(
                                    AppCubit.get(context).posts[index],
                                  )
                                : showToast(
                                    text: 'aleardy added',
                                    state: ToastStates.WARNING);
                          },
                        ),
                      ),
                    )
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

  /*
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
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
                        Text(
                          '${model.date}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 300.0,
                    height: 200.0,
                    child: PageView.builder(
                      controller: AdsImages,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Image(
                        image: NetworkImage('${model.postImage![index]}'),
                        width: 200.0,
                        height: 120.0,
                      ),
                      itemCount: model.postImage!.length,
                    ),
                  ),

                  /* Image(
                    image: NetworkImage('${model.postImage}'),
                  ),
                  */
                  /*
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      color: Colors.blue,
                      width: 60.0,
                      height: 25.0,
                      child: Text('${model.category}'),
                    ),
                  ),
                  */
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          '${model.no_of_room}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.king_bed_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${model.no_of_bathroom}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.bathtub_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${model.area}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'm',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.house_outlined),
                            Text('${model.namePost}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.description),
                            Text(
                              '${model.description}',
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.place),
                            Text('${model.place}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.price_change_rounded),
                            Text('${model.price}'),
                            const SizedBox(
                              width: 12.0,
                            ),
                            const Icon(Icons.category),
                            Text('${model.category}'),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context).addtofav(
                                    AppCubit.get(context).posts[index],
                                    AppCubit.get(context).postsId[index],
                                  );
                                },
                                icon: const Icon(Icons.favorite,
                                    color: Colors.grey)),
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context).deletPost(
                                      AppCubit.get(context).postsId[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),*/

}
