import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_note/data/models/kraat_model.dart';
import 'package:e_note/data/models/user_model.dart';
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
    UserModel userModel = UserModel(
        fullName,
        email,
        userId,
        phone,
        password,
        gender,
        birthDate,
        teamId,
        userType,
        payId);
    return firebase.collection('users').doc(userId).set(userModel.toMap());
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
    return firebase
        .collection('users')
        .doc(userId)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserAttendData() {
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('attend')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getKraatData() {
    return firebase.collection('users').doc(constUid).collection('kraat').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserMarathonAnswerData() {
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('marathon')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMarathonData() {
    return firebase.collection('admin').doc(payId).collection('marathon').get();
  }

  Future<void> createUserMarathonAnswer({
    required String marathonId,
    required String answer,
    required String comment,
  }) async {
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('marathon')
        .doc(marathonId)
        .set({
      'answer': answer,
      'comment': comment,
      'modifiedTime': DateTime.now().toString(),
    });
  }

  Future<void> createUserKraat({
    required bool baker,
    required bool talta,
    required bool sata,
    required bool tas3a,
    required bool grob,
    required bool noom,
    required bool ertgalyBaker,
    required bool ertgalyNom,
    required bool tnawel,
    required bool odas,
    required bool eatraf,
    required bool soom,
    required bool oldBible,
    required bool newBible,
  }) async {
    KraatModel kraatModel = KraatModel(
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        baker,
        talta,
        sata,
        tas3a,
        grob,
        noom,
        ertgalyBaker,
        ertgalyNom,
        tnawel,
        odas,
        eatraf,
        soom,
        oldBible,
        newBible);
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('kraat')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .set(kraatModel.toMap());
  }
}
