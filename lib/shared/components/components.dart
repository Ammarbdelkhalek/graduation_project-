import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false,
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
//    String? Function(String?)? ontap,
//   Function? ontap,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  bool isClickable = true,
  VoidCallback? suffixpressed,
  VoidCallback? ontap,
  final TextStyle? labelStyle,
  Color? color,
  final TextStyle? style,
}) =>
    TextFormField(
      validator: validate,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: ontap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        prefixIcon: Icon(
          prefix,
          color: color,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpressed,
                icon: Icon(
                  suffix,
                  color: color,
                ))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: style,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  bool? isUpperCase,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

//enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

List<Widget> carouselSliderImages = [
  Image.network(
    'https://vietnaminsider.vn/wp-content/uploads/2019/09/billboard-novaworld-phan-thiet-585x329.jpg',
    width: double.infinity,
  ),
  Image.network(
    'https://images.template.net/wp-content/uploads/2019/05/Real-Estate-Banner-Ad-Templates.jpg',
    width: double.infinity,
  ),
  Image.network(
    'https://en.pimg.jp/067/276/608/1/67276608.jpg',
    width: double.infinity,
  ),
];


/*
  List<XFile> postimages = [];
 // List<String> addStreamImageUrl = [];
  var pickerimage = ImagePicker();

  Future<void> getpostImages({
    required String addStreamTitle,
  }) async {
    emit(PostImagePickedSuccessState());
    final List<XFile>   ? pickedImages = await picker.pickMultiImage();
    if (pickedImages!.isNotEmpty) {
      addStreamImage = [];
      addStreamImageUrl = [];
      addStreamImage.addAll(pickedImages);
      uploadAddStreamImage(addStreamTitle: addStreamTitle);
    } else {
      emit(PostImagePickedErrorState());
    }
  }

  void uploadAddStreamImage({
    required String addStreamTitle,
  }) {
    if (addStreamImage.isNotEmpty) {
      for (int i = 0; i < addStreamImage.length; i++) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(FirebaseAuth.instance.currentUser!.email!)
            .child(addStreamTitle)
            .child(addStreamImage[i].name)
            .putFile(File(addStreamImage[i].path))
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            addStreamImageUrl.add(value.toString());
            if (addStreamImageUrl.length == addStreamImage.length) {
              emit(AppPickAddStreamImageSuccessState()); 
            }
          }).catchError((error) {
            emit(AppUploadAddStreamImageErrorState(error: error.toString()));
          });
        }).catchError((error) {
          emit(AppUploadAdd StreamImageErrorState(error: error.toString()));
        });
      }
    }
  }
  */

  