import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/chat/chat_screen.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/favourite/favourite_screen.dart';
import 'package:realestateapp/modules/home/home_screen.dart';
import 'package:realestateapp/modules/login/login_screen.dart';
import 'package:realestateapp/modules/setting/myaccount.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';
import '../../models/category_model.dart';
import '../../models/chatmodel.dart';
import '../../models/faviouritemodel.dart';
import '../category/categoryscreen.dart';

const String _url = 'https://flutter.dev';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String? currentvalue;

  void dropdownlist(value) {
    currentvalue = value;
    emit(DropdownListCHange());
  }

  UserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  List<Widget> Screens = [
    HomeScreen(),
    Categoryscreen(),
    FavouriteScreen(),
    ChatScreen(),
    useraccount()
  ];

  int currentIndex = 0;

  void ChangeBottomNav(int index) {
    if (index == 3) getAllUsers();
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(UploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          image: value,
        );
        // profileImageUrl = value;
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());

      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      image: image ?? userModel!.image,
      uid: userModel!.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'uid').then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({bool? themeMode}) {
    if (themeMode != null) {
      isDark = themeMode;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(PostImagePickedErrorState());
    }
  }

  void UploadNewPost({
    required String namePost,
    required String description,
    required String place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String category,
    required String price,
    required String date,

    // required String postImage,
  }) {
    emit(AppCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(SocialUploadCoverImageSuccessState());
        print(value);
//        coverImageUrl = value;
        CreatePost(
          namePost: namePost,
          description: description,
          area: area,
          place: place,
          no_of_room: no_of_room,
          no_of_bathroom: no_of_bathroom,
          date: date,
          postImage: value,
        );
      }).catchError((error) {
        emit(AppCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(AppCreatePostErrorState(error.toString()));
    });
  }

  void CreatePost({
    required String namePost,
    required String description,
    required String place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String postImage,
    required String date,
  }) {
    emit(AppCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uid: userModel!.uid,
      image: userModel!.image,
      namePost: namePost,
      description: description,
      place: place,
      no_of_room: no_of_room,
      no_of_bathroom: no_of_bathroom,
      area: area,
      postImage: postImage,
      category: currentvalue,
      date: date,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(AppCreatePostSuccessState());
    }).catchError((error) {
      emit(AppCreatePostErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(AppRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  PostModel? postModel;
  void getPosts() {
    posts = [];
    emit(AppGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        print(element.id);
        postsId.add(element.id);
        //  comments.add(SocialCommentPostModel.fromJson(element.data()));
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(AppGetPostsSuccessState());
    });
    emit(AppGetPostsErrorState(Error.safeToString(Error)));
  }

  void deletPost(String postid) {
    userposts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .delete()
        .then((value) {
      emit(AppRemoveFrompostsSuccessState());
      userposts = [];
      getUserAds();
      print('delete sucssed');
      print('===================================================');
    }).catchError((error) {
      print(error.toString());
      print('=============================================');
      emit(AppRemoveFrompostsErrorState(error: error.toString()));
      print(error.toString());
      print('=============================================');
    });
  }

  List<String> drobdownlist = [];
  CategoryDataModel? categoryDataModel;
  List<CategoryDataModel> categories = [];
  void getCategoryData() {
    categories = [];
    drobdownlist = [];
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      value.docs.forEach((element) {
        categories.add(CategoryDataModel.fromJson(element.data()));

        print(element.data());
      });
      for (int i = 0; i < categories.length; i++) {
        drobdownlist.add(categories[i].categoryName.toString());
      }
      emit(AppGetCategoryDataSuccessState());
      print(categories);
      print(drobdownlist);
    }).catchError((error) {
      print(error.toString());
      emit(AppGetCategoryDataErrorState(error: error));
    });
  }

  bool isfav = false;
  void addtofav(
    PostModel model,
    String postid,
  ) {
    isfav = !isfav;
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    FavoriteDataModel favoriteDataModel = FavoriteDataModel(
        namePost: model.namePost,
        no_of_bathroom: model.no_of_bathroom,
        no_of_room: model.no_of_room,
        area: model.area,
        price: model.price,
        postImage: model.postImage,
        description: model.description,
        date: model.date,
        uid: model.uid,
        postid: model.postid,
        isfav: false);
    FirebaseFirestore.instance
        .collection('favorite')
        .doc(currentUser!.uid)
        .collection('items')
        .doc(postid)
        .set(favoriteDataModel.toMap())
        .then((value) {
      isfav = !isfav;
      emit(AppAddToFavoritesSuccessState());
      print("data faviourite is succesedd");
    }).catchError((error) {
      isfav = !isfav;
      emit(AppAddToFavoritesErrorState());
    });
  }

  List<FavoriteDataModel> favorites = [];
  void getfaviourite() {
    favorites = [];
    emit(AppgetToFavoritesloadingState());
    FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        favorites.add(FavoriteDataModel.fromJson(element.data()));
        print(element.data());
      });

      emit(AppgetToFavoritesSuccessState());
    });

    emit(AppgetToFavoritesErrorState(error: Error.safeToString(Error)));
  }

  void deletefavorite(
    String postid,
  ) {
    favorites = [];
    FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc(postid)
        .delete()
        .then((value) {
      emit(AppRemoveFromFavoritesSuccessState());
      favorites = [];
      getfaviourite();
    }).catchError((error) {
      print(error.toString());
      print(
          '===================================================================');
      emit(AppRemoveFromFavoritesErrorState(error: error.toString()));
      print(error.toString());
      print(
          '===================================================================');
    });
  }
  // message function

  List<UserModel> users = [];

  getAllUsers() {
    users = [];
    emit(AppGetAllUserLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != userModel!.uid)
          users.add(UserModel.fromJson(element.data()));
        emit(AppGetAllUserSuccessState());
      });
    }).catchError((error) {
      emit(AppGetAllUserErrorState(error));
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      senderId: userModel!.uid,
      text: text,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> Messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      Messages = [];

      event.docs.forEach((element) {
        Messages.add(MessageModel.fromJson(element.data()));
      });
      emit(AppGetMessagesSuccessState());
    });
  }

  List<PostModel> categoryPosts = [];

  void getCategoryProducts({required String categoryname}) {
    categoryPosts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .where("category", isEqualTo: categoryname)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        categoryPosts.add(PostModel.fromJson(element.data()));
        print(categoryPosts.length);
      });
      emit(AppGetCategoryProductsSuccessState());
    }).catchError((error) {
      emit(AppGetCategoryProductsErrorState(error.toString()));
    });
  }

  List<PostModel> userposts = [];
  void getUserAds() {
    userposts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userposts.add(PostModel.fromJson(element.data()));
        print(userposts.length);
      });
      emit(AppGetUserADSSuccessState());
    }).catchError((error) {
      emit(AppGetUserADSErrorState(error.toString()));
    });
  }

  void whatsAppOpen(String phone) async {
    await FlutterLaunch.launchWhatsapp(
        phone: phone,
        message: 'how are you ammar iwant to contact with you please');
  }

  CameraPosition? kGooglePlex;
  bool? services;
  Position? currentposition;
  var lat;
  var long;
  Future getpermission(context) async {
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        body: const Center(
          child: Text(
            'services denied ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'services',
      ).show();
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always) {
      getlatAndlang();
      return permission;
    }
  }

  Future<void> getlatAndlang() async {
    currentposition =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentposition!.latitude;
    long = currentposition!.longitude;
    kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    emit(getLatAndLongStates());
  }

  void updatePostImage({
    required String name,
    required String uid,
    required String image,
    required String namePost,
    required String description,
    required String place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String price,
  }) {
    emit(UpdatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        print(value);
        updatePost(
          name: userModel!.name!,
          uid: userModel!.uid!,
          image: userModel!.image!,
          category: postModel!.category!,
          namePost: namePost,
          description: description,
          place: place,
          no_of_room: no_of_room,
          no_of_bathroom: no_of_bathroom,
          area: area,
          price: price,
          postImage: value,
        );
        // profileImageUrl = value;
      }).catchError((error) {
        emit(UploadPostImageErrorState(error.toString()));
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState(error.toString()));
    });
  }

  void updatePost({
    required String name,
    required String uid,
    required String image,
    required String namePost,
    required String description,
    required String place,
    required String category,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String price,
    String? postid,
    String? postImage,
  }) {
    emit(UpdatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        uid: userModel!.uid,
        image: userModel!.image,
        category: postModel!.category,
        namePost: namePost,
        description: description,
        place: place,
        no_of_room: no_of_room,
        no_of_bathroom: no_of_bathroom,
        area: area,
        price: price,
        postid: postid);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .update(model.toMap())
        .then((value) {
      getPosts();
      print(
          '===========================================================================');
      print('uppdated successfuly ');
    }).catchError((error) {
      emit(UpdatePostErrorState(error.toString()));
      print(error.toString());
    });
  }

////////////////////////////////////////////test muilty images ///////////////////////

  List<XFile> addImages = [];
  List<String> addImagesUrl = [];
  var pickerimage = ImagePicker();
  Future<void> getImages() async {
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    if (pickedImages!.isNotEmpty) {
      addImages = [];
      addImagesUrl = [];
      addImages.addAll(pickedImages);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
    }
  }
}
