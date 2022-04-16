import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/faviouritemodel.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import '../../shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

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
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /* Row(
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
                      const Text(
                        'Broker',
                        style: TextStyle(
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
            ),*/
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.postImage}'),
                ),
                Row(
                  children: [
                    Text(
                      '${model.no_of_room}',
                      style: TextStyle(
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
                          Text('${model.description}'),
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
                          const Icon(Icons.price_change_outlined),
                          Text('${model.price}'),
                          const SizedBox(
                            width: 12.0,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite)),
                          const SizedBox(
                            width: 12.0,
                          ),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context).deletefavorite(
                                    AppCubit.get(context).postsId[index]);
                              },
                              icon: const Icon(Icons.delete)),
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
}
