abstract class KhademState {}

class InitialKhademState extends KhademState {}

class SignUpSuccessKhademState extends KhademState {}

class SignUpErrorKhademState extends KhademState {
  late String error;

  SignUpErrorKhademState(this.error);
}

class SignUpLoadingKhademState extends KhademState {}

class LoginSuccessKhademState extends KhademState {
  late String uId;

  LoginSuccessKhademState(this.uId);
}

class LoginLoadingKhademState extends KhademState {}

class LoginErrorKhademState extends KhademState {
  late String error;

  LoginErrorKhademState(this.error);
}

class CreateSuccessKhademState extends KhademState {}

class CreateLoadingKhademState extends KhademState {}

class CreateErrorKhademState extends KhademState {
  late String error;

  CreateErrorKhademState(this.error);
}

class LogOutSuccessKhademState extends KhademState {}
