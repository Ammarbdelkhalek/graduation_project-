import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/category_model.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/modules/new_post/new_post.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppAddToFavoritesSuccessState) {
        showToast(
            text: 'faviourite added successfuly ', state: ToastStates.SUCCESS);
      }
    }, builder: (context, state) {
      return
          /* SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 200,
            child: BuildCarusal(context),
          ),
        ),*/
          ConditionalBuilder(
        condition: AppCubit.get(context).posts.length > 0 &&
            AppCubit.get(context).userModel != null,
        builder: (context) => Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                  onTap: (() {
                    navigateTo(context,
                        Ads_Details(model: AppCubit.get(context).posts[index]));
                  }),
                  child: BuildPost(
                      AppCubit.get(context).posts[index], context, index)),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: AppCubit.get(context).posts.length,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                onPressed: () {
                  navigateTo(context, NewPost());
                },
                child: const Icon(Icons.add_card),
              ),
            )
          ],
        ),
        fallback: (context) => AppCubit.get(context).posts.length == 0
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
                    const Text(
                      ' you have no posts  ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        navigateTo(context, NewPost());
                      },
                      child: const Icon(Icons.add_card),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }

  Widget BuildCarusal(BuildContext context) => ListView(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CarouselSlider(
              items: const [
                Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/3d-rendering-large-modern-contemporary-house-wood-concrete-early-evening_190619-1492.jpg?w=1380',
                  ),
                ),
                Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/3d-rendering-large-modern-contemporary-house-wood-concrete_190619-1484.jpg?w=1380',
                  ),
                ),
                Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/business-man-create-design-modern-building-real-estate_35761-316.jpg?w=1380',
                  ),
                ),
                Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/making-money-with-property-real-estate-investment_35761-380.jpg?w=1380',
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
              ),
            ),
          ),
        ],
      );

  Widget BuildCategoryItems(CategoryDataModel? categoryDataModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                width: 100,
                height: 80,
                image: NetworkImage('${categoryDataModel!.categoryImage}'),
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                '${categoryDataModel.categoryName}',
                style: const TextStyle(
                  fontSize: 17.0,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ],
      ),
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
                  Image(
                    image: NetworkImage('${model.postImage}'),
                  ),
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
                                icon: Icon(Icons.favorite,
                                    color: AppCubit.get(context).isfav
                                        ? Colors.blue
                                        : Colors.grey)),
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
