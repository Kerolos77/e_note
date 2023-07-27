import 'package:e_note/data/models/user_attend_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/local/cache_helper.dart';
import 'view_team_attend_states.dart';

class ViewTeamAttendCubit extends Cubit<ViewTeamAttendStates> {
  ViewTeamAttendCubit() : super(InitialViewTeamAttendState());

  static ViewTeamAttendCubit get(context) => BlocProvider.of(context);

  late UserAttendModel attendModel;
  int userIndex = 0;
  List<String> names = [];
  Map<String, String> ids = {};

  List<UserAttendModel> userAttendList = [];
  Map<String, dynamic>? user;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  void getTeamUsers() {
    teamId = CacheHelper.getData(key: 'teamId');
    emit(GetUsersLoadingViewTeamAttendState());
    firebaseReposatory.getTeamUsers().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        // userList.add(value.docs[i].data());
        names.add(
            "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}");
        ids.addAll({
          "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}":
              value.docs[i].data()['id'],
        });
      }
      emit(GetUsersSuccessViewTeamAttendState());
    });
  }

  void getUserAttend(String userId) {
    emit(GetUserAttendLoadingViewTeamAttendState());
    firebaseReposatory.getUserAttendData(userId: userId).then((value) {
      userAttendList = [];
      for (int i = 0; i < value.docs.length; i++) {
        attendModel = UserAttendModel(
            value.docs[i].id,
            value.docs[i].data()['lecture 1'] ?? '-------',
            value.docs[i].data()['lecture 2'] ?? '-------');
        userAttendList.add(attendModel);
      }
      emit(GetUserAttendSuccessViewTeamAttendState());
    });
  }
}
