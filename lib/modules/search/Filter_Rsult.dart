import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/shared/components/constant.dart';

import '../../shared/components/components.dart';

class Filter_Result extends StatelessWidget {
  Filter_Result(this.postmodel, {Key? key}) : super(key: key);
  PostModel? postmodel;

  PageController AdsImages = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postmodel = AppCubit.get(context).postModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Search Results '),
            leading: MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              ConditionalBuilder(
                  condition: AppCubit.get(context).filterAds.isNotEmpty,
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
                                    AppCubit.get(context).filterAds[index],
                                    context,
                                    index)),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: AppCubit.get(context).filterAds.length,
                          ),
                        ],
                      ),
                  fallback: (context) =>
                      AppCubit.get(context).filterAds.length == 0
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
                                    ' No Result Matched ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          : CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
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
