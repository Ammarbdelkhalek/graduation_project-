import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:realestateapp/models/category_model.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';

class rentcategory extends StatelessWidget {
  int index = 0;

  rentcategory(this.categoryDataModel, {Key? key}) : super(key: key);
  CategoryDataModel? categoryDataModel;
  var categoryADSController = PageController();
  @override
  Widget build(
    BuildContext context,
  ) {
    AppCubit.get(context)
        .getCategoryProducts(categoryname: categoryDataModel!.categoryName!);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                categoryDataModel!.categoryName.toString().toUpperCase(),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ConditionalBuilder(
              condition: AppCubit.get(context).categoryPosts.isNotEmpty &&
                  AppCubit.get(context).userModel != null,
              builder: (context) => Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                        onTap: (() {
                          navigateTo(
                              context,
                              Ads_Details(
                                  model: AppCubit.get(context)
                                      .categoryPosts[index]));
                        }),
                        child: BuildPost(
                            AppCubit.get(context).categoryPosts[index],
                            context,
                            index)),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: AppCubit.get(context).categoryPosts.length,
                  ),
                ],
              ),
              fallback: (context) =>
                  AppCubit.get(context).categoryPosts.length == 0
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
                                ' this category not available ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
            ),
          );
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
                          controller: categoryADSController,
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
                            // icon: AppCubit.get(context).favorites.length == 0
                            //     ? const Icon(
                            //         Icons.favorite_rounded,
                            //       )
                            //     : const Icon(
                            //         Icons.favorite_rounded,
                            //         color: Colors.red,
                            //       ),
                            onPressed: () {
                              // AppCubit.get(context).favorites.length == 0
                              //     ? AppCubit.get(context).addtofav(
                              //         AppCubit.get(context).posts[index],
                              //       )
                              //     : showToast(
                              //         text: 'aleardy added',
                              //         state: ToastStates.WARNING);
                            },
                            icon: const Icon(
                              Icons.favorite_rounded,
                            )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${model.type}',
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
                        '${model.type}',
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
