import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/kraat_model.dart';
import 'view_kraat_team_states.dart';

class ViewKraatTeamCubit extends Cubit<ViewKraatTeamStates> {
  ViewKraatTeamCubit() : super(InitialViewKraatTeamState());

  static ViewKraatTeamCubit get(context) => BlocProvider.of(context);

  late KraatModel kraatModel;
  int userIndex = 0;
  List<String> names = [];
  Map<String, String> ids = {};

  List<KraatModel> kraatList = [];
  Map<String, dynamic>? user;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  void getTeamUsers() {
    teamId = CacheHelper.getData(key: 'teamId');
    emit(GetUsersLoadingViewKraatTeamState());
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
      emit(GetUsersSuccessViewKraatTeamState());
    });
  }

  void getUserKraat(String userId) {
    emit(GetUserKraatLoadingViewKraatTeamState());

    firebaseReposatory.getKraatData(userId: userId).then((value) {
      kraatList = [];
      for (int i = 0; i < value.docs.length; i++) {
        print(value.docs[i].data()['date']);
        kraatModel = KraatModel(
          value.docs[i].data()['date'],
          value.docs[i].data()['baker'],
          value.docs[i].data()['talta'],
          value.docs[i].data()['sata'],
          value.docs[i].data()['tas3a'],
          value.docs[i].data()['grob'],
          value.docs[i].data()['noom'],
          value.docs[i].data()['ertgalyBaker'],
          value.docs[i].data()['ertgalyNom'],
          value.docs[i].data()['tnawel'],
          value.docs[i].data()['odas'],
          value.docs[i].data()['eatraf'],
          value.docs[i].data()['soom'],
          value.docs[i].data()['oldBible'],
          value.docs[i].data()['newBible'],
        );
        kraatList.add(kraatModel);
      }
      emit(GetUserKraatSuccessViewKraatTeamState());
    }).catchError((error) {
      print('error ${error.toString()}');
    });
  }
}
