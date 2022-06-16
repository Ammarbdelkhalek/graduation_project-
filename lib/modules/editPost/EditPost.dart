import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/home_screen.dart';
import 'package:realestateapp/modules/setting/userprofile.dart';
import 'package:realestateapp/shared/components/components.dart';

class EditPost extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var NamePostController = TextEditingController();
  var DescriptionController = TextEditingController();
  var PlaceController = TextEditingController();
  var no_of_roomsController = TextEditingController();
  var no_of_bathroomController = TextEditingController();
  var AreaController = TextEditingController();
  var PriceController = TextEditingController();

  PostModel? postmodel;
  EditPost({this.postmodel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdatePostSuccessState) {
          showToast(text: 'success', state: ToastStates.SUCCESS);
          navigateTo(context, User_Profile(postmodel));
          AppCubit.get(context).getUserAds();
        }
        if (state is UpdatePostErrorState) {
          showToast(text: 'failed', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        //var profileImage = AppCubit.get(context).postImage;

        NamePostController.text = postmodel!.namePost!;
        DescriptionController.text = postmodel!.description!;
        // PlaceController.text = postmodel!.place!;
        no_of_roomsController.text = postmodel!.no_of_room!;
        no_of_bathroomController.text = postmodel!.no_of_bathroom!;
        AreaController.text = postmodel!.area!;
        PriceController.text = postmodel!.price!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdatePostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is UpdatePostLoadingState)
                      const SizedBox(
                        height: 10,
                      ),
                    Text('Update Post'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: NamePostController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name of Advertisment';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: DescriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.description),
                                hintText: 'describtion',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: PlaceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter place';
                              }
                            },
                            label: 'Place',
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
                                return 'Please Enter no_of_rooms';
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
                                return 'Please Enter no_of_bathrooms';
                              }
                            },
                            label: 'Number of Bathrooms',
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
                                return 'Please Enter Area';
                              }
                            },
                            label: 'Area',
                            prefix: Icons.space_bar_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: PriceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Price';
                              }
                            },
                            label: 'Price',
                            prefix: Icons.price_change_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /*
                          TextButton(
                            onPressed: () {
                              AppCubit.get(context).getPostImage();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.photo_library_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add Photo',
                                ),
                              ],
                            ),
                          ),
                          */
                          /*
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: Image(
                                  image: AppCubit.get(context).postImage == null
                                      ? NetworkImage('${postmodel!.postImage}')
                                      : FileImage(
                                              AppCubit.get(context).postImage!)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context).getPostImage();
                                },
                                icon: Icon(Icons.camera_alt),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          */
                        ],
                      ),
                    ),
                    //
                    // if (AppCubit.get(context).postImage != null)
                    /*
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            /* if (formKey.currentState!.validate()) {
                                AppCubit.get(context).updatePostImage(
                                  name: AppCubit.get(context).userModel!.name!,
                                  uid: AppCubit.get(context).userModel!.uid!,
                                  image:
                                      AppCubit.get(context).userModel!.image!,
                                  namePost: NamePostController.text,
                                  description: DescriptionController.text,
                                  place: PlaceController.text,
                                  no_of_room: no_of_roomsController.text,
                                  no_of_bathroom: no_of_bathroomController.text,
                                  area: AreaController.text,
                                  price: PriceController.text,
                                );
                              }
                              */
                          },
                          child: const Text(
                            'Upload Post Image',
                          ),
                        ),
                      ],
                    ),
                    */
                    OutlinedButton(
                      onPressed: ({currentindex}) {
                        var index = 0;
                        currentindex = index;
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).updatePost(
                              //    type: postmodel!.type!,
                              namePost: NamePostController.text,
                              description: DescriptionController.text,
                              place: PlaceController.text,
                              no_of_room: no_of_roomsController.text,
                              no_of_bathroom: no_of_bathroomController.text,
                              area: AreaController.text,
                              price: PriceController.text,
                              category: postmodel!.category!,
                              postImage: postmodel!.postImage!,
                              date: postmodel!.date!,
                              postid: AppCubit.get(context).postsId[index]);
                        }
                      },
                      child: const Text(
                        'Update Post',
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
