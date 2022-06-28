import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/models/BundleModel.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/home_screen.dart';
import 'package:realestateapp/modules/map/map.dart';
import 'package:realestateapp/modules/map/map_screen.dart';
import 'package:realestateapp/shared/components/components.dart';
import '../../shared/components/constant.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool isnogiate = false;
  var formKey = GlobalKey<FormState>();
  var NamePostController = TextEditingController();
  var DescriptionController = TextEditingController();
  var PlaceController = TextEditingController();
  var no_of_roomsController = TextEditingController();
  var no_of_bathroomController = TextEditingController();
  var AreaController = TextEditingController();
  var PriceController = TextEditingController();
  var datecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var phoneNumberWhatsAppController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getpermission(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreatePostSuccessState) {
          showToast(
              text: 'post created successfully'.tr().toString(),
              state: ToastStates.SUCCESS);
          navigateTo(context, LayoutScreen());
        }
      },
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
       // phonecontroller.text = userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text('New Post'.tr().toString()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is AppCreatePostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is AppCreatePostLoadingState)
                      const SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel!.image}',
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
                                      '${AppCubit.get(context).userModel!.name}',
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: Colors.blue,
                                    ),
                                  ]),
                              Text(
                                'now'.tr().toString(),
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.blue,
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
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
                              hintText: 'Select type like Rent or Buy '
                                  .tr()
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                            controller: NamePostController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name of Advertisement'
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Name'.tr().toString(),
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: DescriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.description),
                                hintText: 'Description'.tr().toString(),
                                border: const OutlineInputBorder()),
                          ),


                          const SizedBox(
                            height: 8.0,
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
                              hintText:
                                  'Select your category '.tr().toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: PlaceController,
                            onChange: (location) {},
                            ontap: () {
                              navigateTo(context, MapScreen());
                            },
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter place'.tr().toString();
                              }
                            },
                            label: 'Select the location'.tr().toString(),
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
                                return 'Please Enter no of rooms'
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Number of Rooms'.tr().toString(),
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
                                return 'Please Enter no of bathrooms'
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Number of Bathrooms'.tr().toString(),
                            prefix: Icons.bathtub_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: AreaController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Area'.tr().toString();
                              }
                            },
                            label: 'Area'.tr().toString(),
                            prefix: Icons.space_bar_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Negotiability'.tr().toString()),
                          Checkbox(
                              value: isnogiate,
                              onChanged: (value) {
                                setState(() {
                                  isnogiate = value!;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: PriceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Price'.tr().toString();
                              }
                            },
                            label: 'Price'.tr().toString(),
                            prefix: Icons.price_change_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email'
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Email'.tr().toString(),
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: phonecontroller,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number is Required '
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Phone '.tr().toString(),
                            prefix: Icons.price_change_outlined,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: phoneNumberWhatsAppController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'WhatsApp Phone number is Required '
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'WhatsApp Phone '.tr().toString(),
                            prefix: Icons.price_change_outlined,
                          ),



                          const SizedBox(
                            height: 10.0,
                          ),
                          DropdownButtonFormField(
                            items: AppCubit.get(context).BundeList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).bundlelist(newValue);
                            },
                            value: AppCubit.get(context).currentbundleValue,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText:
                                  'Select your Bundle like  Gold or Silver '
                                      .tr()
                                      .toString(),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              AppCubit.get(context).getImages();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.photo_library_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add Photo'.tr().toString(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 300,
                            child: GridView.builder(
                                itemCount:
                                    AppCubit.get(context).addImages.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Image.file(
                                    File(AppCubit.get(context)
                                        .addImages[index]
                                        .path),
                                    fit: BoxFit.cover,
                                  );
                                }),
                          ),
                        ],
                      ),
                      //   ],
                    ),
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (state is PostImagePickedSuccessState) {
                            AppCubit.get(context).uploadpostandimage(
                                Bundle: AppCubit.get(context).Bundel.toString(),
                                isnegotiate: false,
                                type: AppCubit.get(context).AdsType.toString(),
                                namePost: NamePostController.text,
                                description: DescriptionController.text,
                                place: PlaceController.text,
                                no_of_room: no_of_bathroomController.text,
                                no_of_bathroom: no_of_bathroomController.text,
                                area: AreaController.text,
                                price: PriceController.text.toString(),
                                category:
                                    AppCubit.get(context).categories.toString(),
                                date: DateTime.now().toString(),
                                email: emailController.text,
                                whatsApp: phoneNumberWhatsAppController.text,
                                phone: phonecontroller.text,
                            );

                          }
                        }
                      },
                      child: Text(
                        'Add Post'.tr().toString(),style:TextStyle(color: Colors.greenAccent),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
