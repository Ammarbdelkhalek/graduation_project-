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
  var formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetFilterADSSuccessState) {
          int index = 0;
          navigateTo(
              context, Filter_Result(AppCubit.get(context).postModel));
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
                      key: formkey,
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
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Text('Select your Proper Area'),
                          // Slider(
                          //     activeColor: defaultColor,
                          //     inactiveColor: defaultColor,
                          //     value: AreaValue,
                          //     max: 400,
                          //     divisions: 10,
                          //     label: AreaValue.round().toString(),
                          //     onChanged: (double value) {
                          //       setState(() {
                          //         AreaValue = value;
                          //       });
                          //     }),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text('Select your Proper Price'),
                          // Slider(
                          //   activeColor: defaultColor,
                          //     inactiveColor: defaultColor,
                          //     value: currentvalue,
                          //     max: 10000000,
                          //     divisions: 5,
                          //     label: currentvalue.round().toString(),
                          //     onChanged: (double value) {
                          //       setState(() {
                          //         currentvalue = value;
                          //       });
                          //     }),
                          // const SizedBox(
                          //   height: 16.0,
                          // ),
                          defaultFormField(
                            controller: PriceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your price limit ';
                              }
                            },
                            label: 'enter your price limit ',
                            prefix: Icons.price_change,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: AreaController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your suitable Area';
                              }
                            },
                            label: 'Enter your Suitable Area',
                            prefix: Icons.area_chart_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Center(
                            child: Container(
                              width: 90.0,
                              height: 40.0,
                              color: Colors.greenAccent,
                              child: MaterialButton(
                                onPressed: () {
                                    AppCubit.get(context).filter_search(
                                      place: PlaceController.text,
                                      no_bath: no_of_bathroomController.text,
                                      no_rooms: no_of_roomsController.text,
                                      category:
                                      AppCubit
                                          .get(context)
                                          .currentvalue!,
                                      area: AreaController.text,
                                      price: PriceController.text,
                                      type:
                                      AppCubit
                                          .get(context)
                                          .currenttypeValue!,
                                    );
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


}
