import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/faviouritemodel.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/components/constant.dart';
import '../../shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  var favController = PageController();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getfaviourite();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: AppCubit.get(context).favorites.length > 0 &&
                AppCubit.get(context).userModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => BuildfavoriteItes(
                    AppCubit.get(context).favorites[index], context, index),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: AppCubit.get(context).favorites.length),
            fallback: (context) => AppCubit.get(context).favorites.length == 0
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
                          ' you have no faviourite  ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget BuildfavoriteItes(FavoriteDataModel model, context, index) {
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
                          controller: favController,
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
                            AppCubit.get(context).addtofav(
                              AppCubit.get(context).posts[index],
                            );
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
                    MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).deletefavorite();
                      },
                      child: Text('delete',
                          style: TextStyle(color: Colors.grey[300])),
                    )
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
