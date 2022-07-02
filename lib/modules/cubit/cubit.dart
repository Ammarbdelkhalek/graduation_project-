import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:realestateapp/models/BundleModel.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/servicesmodel.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/HomeServices/homeservics.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/favourite/favourite_screen.dart';
import 'package:realestateapp/modules/home/home_screen.dart';
import 'package:realestateapp/modules/login/login_screen.dart';
import 'package:realestateapp/modules/setting/myaccount.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';
import 'package:realestateapp/shared/network/remote/notification_Dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../models/ContactUsModel.dart';
import '../../models/category_model.dart';
import '../../models/chatmodel.dart';
import '../../models/faviouritemodel.dart';
import '../../shared/network/remote/Diohelper.dart';
import '../category/categoryscreen.dart';
import 'package:dio/dio.dart';

const String _url = 'https://flutter.dev';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String? currentvalue;
  String? currenttypeValue;
  String? currentbundleValue;

  void dropdownlist(value) {
    currentvalue = value;
    emit(DropdownListCHange());
  }

  void typelist(value) {
    currenttypeValue = value;
    emit(DropdownListCHange());
  }

  void bundlelist(value) {
    currentbundleValue = value;
    emit(BundelListChangeState());
  }

  List<String> AdsType = [
    'Rent',
    'Buy',

  ];

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
    AppServices(),
    FavouriteScreen(),

    useraccount(),
  ];

  int currentIndex = 0;

  void ChangeBottomNav(int index) {
    // if (index == 3) getAllUsers();
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
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
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

  void CreatePost({
    required String namePost,
    required String description,
    required String? place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String price,
    required List postImage,
    required bool negotiation,
    required bool Terms,
    required String date,
    required String email,
    required String phone,
    required String whatsApp,
  }) {
    emit(AppCreatePostLoadingState());
    PostModel model = PostModel(
      uid: userModel!.uid,
      namePost: namePost,
      description: description,
      place: place,
      no_of_room: no_of_room,
      no_of_bathroom: no_of_bathroom,
      area: area,
      price: price,
      postImage: imagesUrl,
      category: currentvalue,
      date: DateTime.now().toString(),
      type: currenttypeValue,
      isnegotiate: negotiation,
      TermsAndCondition:Terms,
      bundel: currentbundleValue,
      email: email,
      phone: phone,
      whatsApp: whatsApp,
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
    for (var i = 0; i > addImages.length; i++) {
      addImages[i] == null;
    }

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
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element) {
        print(element.id);
        postsId.add(element.id);
        //  commen0ts.add(SocialCommentPostModel.fromJson(element.data()));
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
      getPosts();
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


  wishlistModel? model;
  List<wishlistModel> favorites = [];
  List<String>favId = [];

  Future addtofav(PostModel model,postid) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    wishlistModel favoriteDataModel = wishlistModel(
      namePost: model.namePost,
      no_of_bathroom: model.no_of_bathroom,
      no_of_room: model.no_of_room,
      area: model.area,
      price: model.price,
      postImage: model.postImage,
      description: model.description,
      category: model.category,
      date: model.date,
      place: model.place,
      uid: FirebaseAuth.instance.currentUser!.uid,
      postid: model.postid,
    );
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc()
        .set(favoriteDataModel.toMap())
        .then((value) {
      emit(AppAddToFavoritesSuccessState());
      print("data faviourite is succesedd");
    }).catchError((error) {
      emit(AppAddToFavoritesErrorState());
    });
  }

  Future getfaviourite() async {
    favorites = [];
    emit(AppgetToFavoritesloadingState());
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((event) {
      favorites = [];
      event.docs.forEach((element) {
        postsId.add(element.id);
        favorites.add(wishlistModel.fromJson(element.data()));
        print(element.id);

        print(element.data());
      });

      emit(AppgetToFavoritesSuccessState());
    });

    emit(AppgetToFavoritesErrorState(error: Error.safeToString(Error)));
  }

  Future deletefavorite(String postid) async {
    favorites=[];
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc(postid)
        .delete()
        .then((value) {
      favorites=[];
      emit(AppRemoveFromFavoritesSuccessState());
      print('deleted sucessfuly');
      getfaviourite();
    }).catchError((error) {
      print(error.toString());
      emit(AppRemoveFromFavoritesErrorState(error: error.toString()));
      print(error.toString());
      print(
          '===================================================================');
    });
  }

  // message function
  //
  // List<UserModel> users = [];
  //
  // getAllUsers() {
  //   users = [];
  //   emit(AppGetAllUserLoadingState());
  //
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     value.docs.forEach((element) {
  //       if (element.data()['uid'] != null)
  //         users.add(UserModel.fromJson(element.data()));
  //       emit(AppGetAllUserSuccessState());
  //     });
  //   }).catchError((error) {
  //     emit(AppGetAllUserErrorState(error));
  //   });
  // }

//
//   void sendMessage({
//     required String receiverId,
//     required String text,
//     required String dateTime,
//   }) {
//     MessageModel model = MessageModel(
//       receiverId: receiverId,
//       senderId: userModel!.uid,
//       text: text,
//       dateTime: dateTime,
//     );
//
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userModel!.uid)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .add(model.toMap())
//         .then((value) {
//       emit(AppSendMessageSuccessState());
//     }).catchError((error) {
//       emit(AppSendMessageErrorState(error.toString()));
//     });
//
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(userModel!.uid)
//         .collection('messages')
//         .add(model.toMap())
//         .then((value) {
//       emit(AppSendMessageSuccessState());
//     }).catchError((error) {
//       emit(AppSendMessageErrorState(error.toString()));
//     });
//   }
//
//   List<MessageModel> Messages = [];
//
//   void getMessages({
//     required String receiverId,
//   }) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userModel!.uid)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .orderBy('dateTime')
//         .snapshots()
//         .listen((event) {
//       Messages = [];
//
//       event.docs.forEach((element) {
//         Messages.add(MessageModel.fromJson(element.data()));
//       });
//       emit(AppGetMessagesSuccessState());
//     });
//   }
//
//   File? chatImage;
//
//   Future<void> pickCatImage() async {
//     final pickedfile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedfile != null) {
//       chatImage = File(chatImage!.path);
//       emit(PickedChatImageSuccessState());
//     } else {
//       print('image not uplodaed try again ');
//     }
//   }
//
// /*
//   void uploadchatimage(String chatimage){
//     firebase_storage.FirebaseStorage.instance.ref(chatimage).child('').
//
//   }
// */
  List<PostModel> categoryPosts = [];

  void getCategoryProducts({required String categoryname}) {
    categoryPosts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .where("category", isEqualTo: categoryname)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        categoryPosts.add(PostModel.fromJson(element.data()));
        print(categoryPosts.length);
      });
      emit(AppGetCategoryProductsSuccessState());
    });
    emit(AppGetCategoryProductsErrorState(Error.safeToString(Error())));
  }

  List<PostModel> userposts = [];

  void getUserAds() {
    userposts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((value) {
      userposts = [];
      value.docs.forEach((element) {
        userposts.add(PostModel.fromJson(element.data()));
        print(userposts.length);
      });
      emit(AppGetUserADSSuccessState());
    });
    emit(AppGetUserADSErrorState(Error.safeToString(Error())));
  }

  void whatsAppOpen(String phone) async {
    await FlutterLaunch.launchWhatsapp(
        phone: phone,
        message: 'how are you ammar iwant to contact with you please');
  }

  void launchEmail(email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
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
      GetLocationFormat(currentposition);
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
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    emit(getLatAndLongStates());
  }

  Future<void> GetLocationFormat(Position? position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position!.latitude, position.longitude);
  }

  void updatePost({
    required String namePost,
    required String description,
    required String place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String price,
    required String postid,
    required String category,
    required List postImage,
    required String date,
    // required String type,
  }) {
    emit(UpdatePostLoadingState());
    PostModel model = PostModel(
      namePost: namePost,
      description: description,
      place: place,
      no_of_room: no_of_room,
      no_of_bathroom: no_of_bathroom,
      area: area,
      price: price,
      category: category,
      postImage: postImage,
      date: date,
      uid: userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .update(model.toMap())
        .then((value) {
      emit(UpdatePostSuccessState());
      getUserAds();
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
  List<String> imagesUrl = [];
  var pickerimage = ImagePicker();

  Future<void> getImages() async {
    final List<XFile>? pickerimage = await picker.pickMultiImage();
    if (pickerimage!.isNotEmpty) {
      addImages = [];
      addImages.addAll(pickerimage);
      print('selected images' + pickerimage.length.toString());
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
    }
  }

  void uploadAddStreamImage() {
    if (addImages.isNotEmpty) {
      for (int i = 0; i < addImages.length; i++) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri
            .file(addImages[i].path)
            .pathSegments
            .last}')
            .putFile(File(addImages[i].path))
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            imagesUrl.add(value.toString());
            if (imagesUrl.length == addImages.length) {
              emit(AppPickAddStreamImageSuccessState());
              print(
                  '===================================================================');
              print('uploaded successfly ');
            }
          }).catchError((error) {
            emit(AppUploadAddStreamImageErrorState(error: error.toString()));
          });
        }).catchError((error) {
          emit(AppUploadAddStreamImageErrorState(error: error.toString()));
        });
      }
    }
  }

  void uploadpostandimage({
    required String namePost,
    required String description,
    required String place,
    required String no_of_room,
    required String no_of_bathroom,
    required String area,
    required String category,
    required String price,
    required String date,
    required String type,
    required bool isnegotiate,
    required bool TermAndCondition,
    required String Bundle,
    required String email,
    required String whatsApp,
    required String phone,

    // required String postImage,
  }) {
    emit(AppCreatePostLoadingState());
    if (addImages.isNotEmpty) {
      for (int i = 0; i < addImages.length; i++) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri
            .file(addImages[i].path)
            .pathSegments
            .last}')
            .putFile(File(addImages[i].path))
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            imagesUrl.add(value.toString());
            print(imagesUrl);
          }).then((value) {
            if (imagesUrl.length == addImages.length) {
              CreatePost(
                namePost: namePost,
                description: description,
                place: place,
                no_of_room: no_of_room,
                no_of_bathroom: no_of_bathroom,
                area: area,
                price: price,
                postImage: imagesUrl,
                negotiation:isnegotiate,
                Terms:TermAndCondition ,
                date: date,
                email: email,
                phone: phone,
                whatsApp: whatsApp,
              );
              print('==========================================');
              print('upload post successfuly ');
            }
          }).catchError((Error) {
            emit(AppCreatePostErrorState(Error.toString()));
          });
        });
      }
    }
  }

  List<PostModel> filterAds = [];

  //List<PostModel> addDataIds = [];
  void filter_search({
    required String place,
    required String category,
    required String no_rooms,
    required String no_bath,
    required String area,
    required String price,
    required String type,
  }) {
    filterAds = [];
    emit(AppGetFilterADSloadingState());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      filterAds = [];
      for (var element in event.docs) {
        if (place == element.data()['place'] &&
            category == element.data()['category'] &&
            no_bath == element.data()['no_of_bathroom'] &&
            no_rooms == element.data()['no_of_room'] &&
            type == element.data()['type']&&
            area == element.data()['area']&&
            price == element.data()['price']
        ) {
          filterAds.add(PostModel.fromJson(element.data()));
        }
        print(element.data());
      }
      emit(AppGetFilterADSSuccessState());

      log('جااااااااااااااااااااااااااااااب جااااااااااااتوه');
      log('=============================================>>>>>>');
    });
    emit(AppGetFilterADSErrorState(Error.safeToString(Error)));
  }

  ServicesModel? servicesModel;
  List<ServicesModel> Service = [];

  void getservice() {
    emit(AppGetServicesloadingState());
    Service = [];
    FirebaseFirestore.instance
        .collection('Service')
        .where('serviceType', isEqualTo: 'Services')
        .snapshots()
        .listen((event) {
      Service = [];
      event.docs.forEach((element) {
        Service.add(ServicesModel.fromJson(element.data()));
        print(element.data());
        print('=================================================>>>');
      });
      emit(AppGetServicesSuccessState());
    });
    emit(AppGetServicesErrorState(Error.safeToString(Error())));
  }

  List<ServicesModel> LawServices = [];

  void getLawService() {
    emit(AppGetServicesloadingState());
    LawServices = [];
    FirebaseFirestore.instance
        .collection('Service')
        .where('serviceType', isEqualTo: 'Law')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        LawServices.add(ServicesModel.fromJson(element.data()));
        print(element.data());
        print('=================================================>>>');
      });
      emit(AppGetServicesSuccessState());
    });
    emit(AppGetServicesErrorState(Error.safeToString(Error())));
  }

  List<PostModel> searchADS = [];

  void getsearch({required String place}) {
    emit(AppGetPostsLoadingState());
    searchADS = [];
    FirebaseFirestore.instance
        .collection('posts')
        .where('place', isEqualTo: place)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        searchADS = [];
        searchADS.add(PostModel.fromJson(element.data()));
        print(element.data());
        print('=================================================>>>');
        emit(AppGetSearchADSSuccessState());
      });
      emit(AppGetSearchADSErrorState(Error.safeToString(Error)));
    });
  }

  BunndelModel? bunndelModel;
  List<String> BundeList = [];
  List<BunndelModel> Bundel = [];

  void getBundle() {
    Bundel = [];
    BundeList = [];
    FirebaseFirestore.instance.collection('Bundle').get().then((value) {
      value.docs.forEach((element) {
        Bundel.add(BunndelModel.fromJson(element.data()));
        print(element.data());
      });
      for (int i = 0; i < Bundel.length; i++) {
        BundeList.add(Bundel[i].bundleName.toString());
      }
      emit(AppGetBundleSuccessState());

      print(Bundel);
      print(BundeList);
    }).catchError((error) {
      print(error.toString());
      emit(AppGetBundelErrorState(error));
    });
  }

//////////////// send notification
  void getUserToken() async {
    emit(GetTokenLoadingState());
    var token = await FirebaseMessaging.instance.getToken();
    print('my token is $token');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'token': token}).then((value) {
      emit(GetTokenSuccessState());
    });
  }

  void sendNotification(UserModel model,
      MessageModel messageModel,) {
    notificationHelper
        .postData(url: 'https://fcm.googleapis.com/fcm/send', data: {
      "to": userModel!.token,
      "notification": {
        "body": messageModel.text,
        "title": userModel!.name,
        "sound": "default"
      },
      "android": {
        "priortiy": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {"messageModel": messageModel.toMap()}
    }).then((value) {
      print("notification pushed");
    }).catchError((error) {
      print(error.toString());
    });
  }

  void CreateContactUs({
    required String name,
    required String email,
    required String phone,
    required String problem,

  }) {
    emit(AppCreateContactUsLoadingState());
    ContactUsModel model = ContactUsModel(
      name: userModel!.name,
      uid: userModel!.uid,
      phone: phone,
      problem: problem,
      email: email,
    );

    FirebaseFirestore.instance
        .collection('ContactUs')
        .add(model.toMap())
        .then((value) {
      emit(AppCreateContactUsSuccessState());
    }).catchError((error) {
      emit(AppCreateContactUsErrorState(error.toString()));
    });
  }
}


