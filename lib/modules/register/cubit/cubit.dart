import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) =>BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String email,
    required String name,
    required String password,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
        name : name,
        email : email,
        phone : phone,
        uid : value.user!.uid,
      );

      //  emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uid,
  })
  {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email : email,
      uid : uid,
      image: 'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
    );

    FirebaseFirestore.instance.collection('users').doc(uid).set(
        model.toMap()
    ).then((value) {
      emit(CreateUserSuccessState(uid));
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
      print('error');
    });
  }

}