abstract class MakhdomState {}

class InitialMakhdomState extends MakhdomState {}

class SignUpSuccessMakhdomState extends MakhdomState {}

class SignUpErrorMakhdomState extends MakhdomState {
  late String error;

  SignUpErrorMakhdomState(this.error);
}

class SignUpLoadingMakhdomState extends MakhdomState {}

class LoginSuccessMakhdomState extends MakhdomState {
  late String uId;

  LoginSuccessMakhdomState(this.uId);
}

class LoginLoadingMakhdomState extends MakhdomState {}

class LoginErrorMakhdomState extends MakhdomState {
  late String error;

  LoginErrorMakhdomState(this.error);
}

class CreateSuccessMakhdomState extends MakhdomState {}

class CreateLoadingMakhdomState extends MakhdomState {}

class CreateErrorMakhdomState extends MakhdomState {
  late String error;

  CreateErrorMakhdomState(this.error);
}

class LogOutSuccessMakhdomState extends MakhdomState {}
