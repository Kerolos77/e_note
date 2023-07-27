import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_note/data/models/marathon_model.dart';
import 'package:e_note/data/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import '../../constants/conestant.dart';
import 'firebase_options.dart';

class FirebaseReposatory {
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> createUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String birthDate,
    required String teamId,
    required String userType,
  }) async {
    UserModel userModel = UserModel(firstName, lastName, email, userId,
        password, gender, birthDate, teamId, userType);
    return firebase.collection('users').doc(userId).set(userModel.toMap());
  }

  Future<void> createMarathon({
    required String id,
    required String title,
    required String content,
    required String modifiedTime,
  }) async {
    MarathonModel marathonModel =
        MarathonModel(id, title, content, modifiedTime);
    return firebase.collection('marathon').doc(id).set(marathonModel.toMap());
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    return FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      {required String userId}) {
    return firebase.collection('users').doc(userId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserAttendData(
      {required String userId}) {
    return firebase.collection('users').doc(userId).collection('attend').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMarathonData() {
    return firebase.collection('marathon').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTeamUsers() {
    print('++++++++++++++++++ $teamId');
    return firebase
        .collection('users')
        .where("teamId", isEqualTo: teamId)
        .where('email', isNotEqualTo: constEmail)
        .get();
  }

  Future<void> createUserAttend({
    required String? userId,
  }) async {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('attend')
        .doc(DateFormat('yyyy - MM - dd').format(DateTime.now()))
        .set({
      'lecture 1': '',
      'lecture 2': '',
    });
  }

  Future<void> createUserKraat({
    required bool baker,
    required bool noom,
    required bool tnawel,
    required bool odas,
    required bool eatraf,
  }) async {
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('kraat')
        .doc(DateFormat('yyyy - MM - dd').format(DateTime.now()))
        .set({
      'baker': baker,
      'noom': noom,
      'tnawel': tnawel,
      'odas': odas,
      'eatraf': eatraf,
    });
  }

  Future<void> updateUserAttend({
    required String? userId,
    required String lectureNum,
  }) async {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('attend')
        .doc(DateFormat('yyyy - MM - dd').format(DateTime.now()))
        .update({
      'lecture $lectureNum': DateFormat('hh : mma').format(DateTime.now())
    });
  }


}
