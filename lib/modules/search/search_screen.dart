import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen(this.model, {Key? key}) : super(key: key);
  PostModel? model;
  var searchcontroller = TextEditingController();
  PageController AdsImages = PageController();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getsearch(place: model!.place!);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('search'.tr().toString()),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    defaultFormField(
                      controller: searchcontroller,
                      onSubmit: (place) {
                        AppCubit.get(context).getsearch(place: place!);
                      },
                      type: TextInputType.text,
                      validate: (value) {},
                      label: 'search',
                      prefix: Icons.search_rounded,
                    ),
                    ConditionalBuilder(
                        condition: AppCubit.get(context).searchADS.isEmpty,
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
                                          AppCubit.get(context)
                                              .searchADS[index],
                                          context,
                                          index)),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount:
                                      AppCubit.get(context).searchADS.length,
                                ),
                              ],
                            ),
                        fallback: (context) => AppCubit.get(context)
                                    .searchADS
                                    .length ==
                                0
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
                            : CircularProgressIndicator())
                  ]),
                )));
      },
    );
  }

  Widget BuildPost(
    PostModel model,
    context,
    index,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: appPadding / 3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 130.0,
              // color: Colors.grey[300],
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 200.0,
                        height: 100.0,
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
                    const SizedBox(width: 8.0),
                    Column(
                      children: [
                        Text(' ${model.name}  '),
                        const SizedBox(height: 8.0),
                        Text(' ${model.place} '),
                        const SizedBox(height: 8.0),
                        Text(
                          '${model.category}',
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
}
