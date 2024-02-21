import 'package:bloc/bloc.dart';
import 'package:e_note/constants/colors.dart';
import 'package:e_note/presentation/screens/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

import 'business_logic/cubit/bloc_observer.dart';
import 'constants/conestant.dart';
import 'data/firecase/firebase_reposatory.dart';
import 'data/firecase/firecbase_fcm.dart';
import 'data/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();
  // // Only call clearSavedSettings() during testing to reset internal values.
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  await FirebaseFCM().initNotifications();
  Bloc.observer = Observer();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await CacheHelper.init();
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  userType = CacheHelper.getData(key: 'userType');
  constUid = CacheHelper.getData(key: 'user');
  teamId = CacheHelper.getData(key: 'teamId');
  constEmail = CacheHelper.getData(key: 'email');
  payId = CacheHelper.getData(key: 'payId');
  // FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  // firebaseReposatory.createUserAttend(userId: constUid, lectureNum: '2');
  // List<String> firstName = ['marathon'];
  // for (int i = 0; i < firstName.length; i++) {
  //   String pass = ID.createId();
  //
  //   String email = '${firstName[i]}@gmail.com';
  //   firebaseReposatory.signUp(email: email, password: pass).then((value) {
  //     firebaseReposatory.createUser(
  //         userId: value.user!.uid,
  //         email: email,
  //         password: pass,
  //         firstName: firstName[i],
  //         lastName: '',
  //         gender: '',
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

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: ConstColors.getMaterialColor(ConstColors.primaryColor),
          useMaterial3: false),
      home: UpgradeAlert(
        showIgnore: false,
        showLater: false,
        child: const SplashScreen(),
      ),
    );
  }
}
