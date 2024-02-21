import 'package:e_note/business_logic/cubit/regidtration/registration_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/local/cache_helper.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  static RegistrationCubit get(context) => BlocProvider.of(context);

  bool registrationFlag = true;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  bool genderFlag = true;

  void changeEnvFlag(flag) {
    genderFlag = flag;
    emit(ChangeEnvState());
  }

  void changeRegistration(bool registrationFlag) {
    this.registrationFlag = registrationFlag;
    emit(ChangeRegistration());
  }

  signUp({
    required String fullName,
    required String email,
    required String password,
    required String gender,
    required String birthDate,
    required String teamId,
    required String userType,
    required String phone,
    required String payId,
  }) async {
    emit(SignUpLoadingRegistrationState());
    firebaseReposatory
        .signUp(email: email, password: password)
        .then((value) => {
              if (value.user?.uid != null)
                {
                  firebaseReposatory
                      .createUser(
                      userId: value.user!.uid,
                      fullName: fullName,
                      phone: phone,
                      email: email,
                      password: password,
                      gender: gender,
                      birthDate: birthDate,
                      teamId: teamId,
                      userType: userType,
                      payId: payId)
                      .then((value) {
                    CacheHelper.putData(key: 'name', value: '');
                    CacheHelper.putData(key: 'email', value: '');
                    CacheHelper.putData(key: 'gender', value: '');
                    CacheHelper.putData(key: 'teamId', value: '');
                    CacheHelper.putData(key: 'birthDate', value: '');
                    CacheHelper.putData(key: 'userType', value: '');
                    CacheHelper.putData(key: 'payId', value: '');
                    emit(SignUpSuccessRegistrationState());
                    registrationFlag = true;
                  }).catchError((error) {
                    emit(SignUpErrorRegistrationState(error.toString()));
                  })
                }
            })
        .catchError((error) {
      emit(SignUpErrorRegistrationState(error.toString()));
    });
  }

  login({
    required email,
    required password,
  }) async {
    emit(LoginLoadingRegistrationState());
    firebaseReposatory.login(email: email, password: password).then((value) {
      constUid = value.user!.uid;
      firebaseReposatory.getUserData(userId: constUid!).then((value) {
        if (value.data() != null) {
          CacheHelper.putData(
              key: 'name', value: '${value.data()!['fullName']}');
          CacheHelper.putData(key: 'gender', value: value.data()!['gender']);
          CacheHelper.putData(key: 'email', value: value.data()!['email'])
              .then((flag) {
            CacheHelper.putData(key: 'teamId', value: value.data()!['teamId'])
                .then((flag) {
              CacheHelper.putData(key: 'payId', value: value.data()!['payId'])
                  .then((flag) {
                teamId = value.data()!['teamId'];
                constEmail = value.data()!['email'];
                payId = value.data()!['payId'];
              });

              emit(LoginSuccessRegistrationState(constUid!));
            });
          });

          CacheHelper.putData(
              key: 'birthDate', value: value.data()!['birthDate']);
          CacheHelper.putData(
              key: 'userType', value: value.data()!['userType']);
        } else {
          logout();
          emit(UserTypeNotAllowedRegistrationState());
        }
      });
    }).catchError((error) {
      emit(LoginErrorRegistrationState(error.toString()));
    });
  }

  logout() {
    firebaseReposatory.logout().then((value) {
      emit(LogoutSuccessRegistrationState());
    }).catchError((error) {
      emit(LogoutErrorRegistrationState(error.toString()));
    });
  }
}
