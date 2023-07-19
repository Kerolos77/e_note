import 'package:e_note/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/conestant.dart';
import 'data/firecase/firebase_reposatory.dart';
import 'data/firecase/firecbase_fcm.dart';
import 'data/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();
  await FirebaseFCM().initNotifications();
  await CacheHelper.init();
  userType = CacheHelper.getData(key: 'userType');
  constUid = CacheHelper.getData(key: 'user');
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  // firebaseReposatory.createUserAttend(userId: constUid, lectureNum: '2');
  List<String> firstName = ['david'];
  // for (int i = 0; i < firstName.length; i++) {
  //   String pass = ID.createId();
  //
  //   String email = '${firstName[i]}_ashraf@gmail.com';
  //   firebaseReposatory.signUp(email: email, password: pass).then((value) {
  //     firebaseReposatory.createUser(
  //         userId: value.user!.uid,
  //         email: email,
  //         password: pass,
  //         firstName: firstName[i],
  //         lastName: 'ashraf',
  //         gender: 'Male',
  //         birthDate: '',
  //         teamId: '',
  //         userType: '');
  //   });
  // }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}
