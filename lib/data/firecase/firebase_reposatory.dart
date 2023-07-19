import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getBarcode({
    required String barcode,
  }) {
    return firebase.collection('barcodes').doc(barcode).get();
  }

  Future<void> createUserAttend({
    required String? userId,
    required String lectureNum,
  }) async {
    return firebase
        .collection('attend')
        .doc(userId)
        .collection(DateFormat('yyyy - MM - dd').format(DateTime.now()))
        .doc('lecture $lectureNum')
        .set({'time': DateFormat('hh : mma').format(DateTime.now())});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCoupons() {
    return firebase
        .collection('users')
        .doc(constUid)
        .collection('coupons')
        .get();
  }

  void updateScore({
    required String score,
  }) {
    firebase.collection('users').doc(constUid).update({
      'score': score,
    });
  }
}
