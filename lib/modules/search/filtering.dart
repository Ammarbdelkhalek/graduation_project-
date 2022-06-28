import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/category_model.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/adsdetails.dart';
import 'package:realestateapp/modules/search/Filter_Rsult.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/styles/colors.dart';

class filter_page extends StatefulWidget {
  filter_page({Key? key}) : super(key: key);
  PostModel? postmodel;
  @override
  State<filter_page> createState() => _filter_pageState();
}

class _filter_pageState extends State<filter_page> {
  PageController AdsImages = PageController();
  var NamePostController = TextEditingController();

  var DescriptionController = TextEditingController();

  var PlaceController = TextEditingController();

  var no_of_roomsController = TextEditingController();

  var no_of_bathroomController = TextEditingController();

  var AreaController = TextEditingController();

  var PriceController = TextEditingController();
  double currentvalue = 0;
  double AreaValue = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetFilterADSSuccessState) {
          int index = 0;
          navigateTo(
              context, Filter_Result(AppCubit.get(context).posts[index]));
        }
      },
      builder: (context, state) {
        var postmodel = AppCubit.get(context).postModel;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('filtering '),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            items: AppCubit.get(context).AdsType.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).typelist(newValue);
                              // do other stuff with _category
                            },
                            value: AppCubit.get(context).currenttypeValue,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Select your Type  ',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            items:
                                AppCubit.get(context).drobdownlist.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).dropdownlist(newValue);
                              // do other stuff with _category
                            },
                            value: AppCubit.get(context).currentvalue,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Select your Category ',
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          defaultFormField(
                            controller: PlaceController,
                            //  ontap: () {
                            // navigateTo(context, MapScreen());
                            //   },
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Place';
                              }
                            },
                            label: 'Select the location',
                            prefix: Icons.place,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: no_of_roomsController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter no of rooms';
                              }
                            },
                            label: 'Number of Rooms',
                            prefix: Icons.king_bed_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: no_of_bathroomController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter no of bathrooms';
                              }
                            },
                            label: 'Number of Bathrooms',
                            prefix: Icons.bathtub_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Select your Proper Area'),
                          Slider(
                              activeColor: defaultColor,
                              inactiveColor: defaultColor,
                              value: AreaValue,
                              max: 400,
                              divisions: 10,
                              label: AreaValue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  AreaValue = value;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Select your Proper Price'),
                          Slider(
                            activeColor: defaultColor,
                              inactiveColor: defaultColor,
                              value: currentvalue,
                              max: 10000000,
                              divisions: 5,
                              label: currentvalue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  currentvalue = value;
                                });
                              }),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Center(
                            child: Container(
                              width: 90.0,
                              height: 40.0,
                              color: Colors.grey,
                              child: MaterialButton(
                                onPressed: () {
                                  AppCubit.get(context).filter_search(
                                    place: PlaceController.text,
                                    no_bath: no_of_bathroomController.text,
                                    no_rooms: no_of_roomsController.text,
                                    category:
                                        AppCubit.get(context).currentvalue!,
                                    area: AreaValue.toString(),
                                    price: PriceController.text,
                                    type:
                                        AppCubit.get(context).currenttypeValue!,
                                  );
                                  price:
                                  currentvalue.toString();
                                },
                                child: const Text('Search'),
                              ),
                            ),
                          ),
                        ]),
                  ))),
        );
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
                                  // AppCubit.get(context).addtofav(
                                  //   AppCubit.get(context).posts[index],
                                  //);
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
