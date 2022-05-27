import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';

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
        return ConditionalBuilder(
            condition: AppCubit.get(context).searchADS.length > 0,
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
                                    model: AppCubit.get(context).posts[index]));
                          }),
                          child: BuildPost(
                              AppCubit.get(context).searchADS[index],
                              context,
                              index)),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: AppCubit.get(context).searchADS.length,
                    ),
                  ],
                ),
            fallback: (context) => AppCubit.get(context).searchADS.length == 0
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
                : CircularProgressIndicator());
      },
    );
  }

  Widget BuildPost(
    PostModel model,
    context,
    index,
  ) =>
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
        ),
      );
}
