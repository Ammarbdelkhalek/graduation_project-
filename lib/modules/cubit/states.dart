import 'package:realestateapp/modules/cubit/cubit.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;
  AppGetUserErrorState(this.error);
}

class AppChangeBottomNavState extends AppStates {}

class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UserUpdateErrorState extends AppStates {}

class UserUpdateLoadingState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppCreatePostLoadingState extends AppStates {}

class AppCreatePostSuccessState extends AppStates {}

class AppCreatePostErrorState extends AppStates {
  final String error;
  AppCreatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends AppStates {}

class PostImagePickedErrorState extends AppStates {}

class AppRemovePostImageState extends AppStates {}

class AppGetPostsLoadingState extends AppStates {}

class AppGetPostsSuccessState extends AppStates {}

class AppGetPostsErrorState extends AppStates {
  final String error;
  AppGetPostsErrorState(this.error);
}

class DropdownListCHange extends AppStates {}

class AppGetCategoryDataSuccessState extends AppStates {}

class AppGetCategoryDataErrorState extends AppStates {
  final error;
  AppGetCategoryDataErrorState({this.error});
}

class AppPickAddStreamImageSuccessState extends AppStates {}

class AppUploadAddStreamImageErrorState extends AppStates {
  final error;
  AppUploadAddStreamImageErrorState({this.error});
}

class AppAddToFavoritesSuccessState extends AppStates {}

class AppAddToFavoritesErrorState extends AppStates {}

class AppgetToFavoritesloadingState extends AppStates {}

class AppgetToFavoritesSuccessState extends AppStates {}

class AppgetToFavoritesErrorState extends AppStates {
  final String? error;
  AppgetToFavoritesErrorState({this.error});
}

class changesfavstate extends AppStates {}

class AppRemoveFromFavoritesSuccessState extends AppStates {}

class AppRemoveFromFavoritesErrorState extends AppStates {
  final error;
  AppRemoveFromFavoritesErrorState({this.error});
}

class AppRemoveFrompostsSuccessState extends AppStates {}

class AppRemoveFrompostsErrorState extends AppStates {
  final error;
  AppRemoveFrompostsErrorState({this.error});
}

class AppGetAllUserLoadingState extends AppStates {}

class AppGetAllUserSuccessState extends AppStates {}

class AppGetAllUserErrorState extends AppStates {
  final String error;
  AppGetAllUserErrorState(this.error);
}

class AppSendMessageSuccessState extends AppStates {}

class AppSendMessageErrorState extends AppStates {
  final String error;
  AppSendMessageErrorState(this.error);
}

class AppGetMessagesLoadingState extends AppStates {}

class AppGetMessagesSuccessState extends AppStates {}

class AppGetMessagesErrorState extends AppStates {}

class AppGetCategoryProductsSuccessState extends AppStates {}

class AppGetCategoryProductsErrorState extends AppStates {
  final String error;
  AppGetCategoryProductsErrorState(this.error);
}

class AppGetUserADSSuccessState extends AppStates {}

class AppGetUserADSErrorState extends AppStates {
  final String error;
  AppGetUserADSErrorState(this.error);
}

class UpdatePostLoadingState extends AppStates {}

class UpdatePostSuccessState extends AppStates {}

class UploadPostImageErrorState extends AppStates {
  final String error;
  UploadPostImageErrorState(this.error);
}

class UpdatePostErrorState extends AppStates {
  final String error;
  UpdatePostErrorState(this.error);
}

class getLatAndLongStates extends AppStates {}

class AppGetSearchADSSuccessState extends AppStates {}

class AppGetSearchADSErrorState extends AppStates {
  final String error;
  AppGetSearchADSErrorState(this.error);
}

class AppGetFilterADSloadingState extends AppStates {}

class AppGetFilterADSSuccessState extends AppStates {}

class AppGetFilterADSErrorState extends AppStates {
  final String error;
  AppGetFilterADSErrorState(this.error);
}

class AppGetServicesloadingState extends AppStates {}

class AppGetServicesSuccessState extends AppStates {}

class AppGetServicesErrorState extends AppStates {
  final String error;
  AppGetServicesErrorState(this.error);
}

class AppGetBundleloadingState extends AppStates {}

class AppGetBundleSuccessState extends AppStates {}

class AppGetBundelErrorState extends AppStates {
  final String error;
  AppGetBundelErrorState(this.error);
}

class BundelListChangeState extends AppStates {}

class GetTokenLoadingState extends AppStates {}

class GetTokenSuccessState extends AppStates {}

class SendNotificationSuccessState extends AppStates {}

class PickedChatImageSuccessState extends AppStates {}

class AppCreateContactUsLoadingState extends AppStates {}
class AppCreateContactUsSuccessState extends AppStates {}
class AppCreateContactUsErrorState extends AppStates {
  final String Error;
  AppCreateContactUsErrorState(
    this.Error,
      );


}


