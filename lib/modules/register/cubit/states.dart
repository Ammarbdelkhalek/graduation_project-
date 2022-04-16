abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates {
  final error;
  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}

class CreateUserSuccessState extends RegisterStates {
  final String uid;
  CreateUserSuccessState(this.uid);
}

class CreateUserErrorState extends RegisterStates {
  final error;
  CreateUserErrorState(this.error);
}