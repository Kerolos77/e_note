import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'attendance_states.dart';

class AttendCubit extends Cubit<AttendStates> {
  AttendCubit() : super(InitialAttendState());

  static AttendCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool lectureFlag = true;
  bool showContainerFlag = false;
  List<dynamic> attendModelList = [];

  Map<String, dynamic>? barcode;

  Map<String, dynamic>? user;

  // void getUserData() {
  //   _firebaseReposatory.getUserData().then((value) {
  //     user = value.data() as Map<String, dynamic>;
  //     emit(GetUserSuccessAttendState());
  //   }).catchError((error) {
  //     emit(GetUserErrorAttendState(error.toString()));
  //   });
  // }

  void changeLectureFlag(flag) {
    lectureFlag = flag;
    emit(ChangeLectureFlagAttendState());
  }

  // void changeShowContainerFlag(flag) {
  //   showContainerFlag = flag;
  //   emit(ChangeAttendState());
  // }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessAttendState());
  }

  void createUserAttend({required String userId}) {
    emit(CreateAttendLoadingAttendState());
    _firebaseReposatory.getUserData(userId: userId).then((value) {
      user = value.data() as Map<String, dynamic>;
      _firebaseReposatory
          .createUserAttend(userId: userId, lectureNum: lectureFlag ? '1' : '2')
          .then((value) {
        emit(CreateAttendSuccessAttendState(user?['name']));
      }).catchError((onError) {
        emit(CreateAttendErrorAttendState(onError.toString()));
      });
    }).catchError((onError) {
      emit(GetUserErrorAttendState(onError.toString()));
    });
  }
}
