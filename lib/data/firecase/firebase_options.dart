// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYerdMTd2G7hAeWY6w-ZchQTHJkqyrm9Y',
    appId: '1:269246041090:web:e1c72531d96d50402f6b1b',
    messagingSenderId: '269246041090',
    projectId: 'e-note-35bda',
    authDomain: 'e-note-35bda.firebaseapp.com',
    storageBucket: 'e-note-35bda.appspot.com',
    measurementId: 'G-ZE3H1ME7SK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaoAn0p6ZtfZdYtIGV2Uu30pJOMa8CsN4',
    appId: '1:269246041090:android:37776c1c1b1430962f6b1b',
    messagingSenderId: '269246041090',
    projectId: 'e-note-35bda',
    storageBucket: 'e-note-35bda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDw-5ASaTIHIKznE_gVykJ_lt-11iMpSk',
    appId: '1:269246041090:ios:4b0f7514656525a32f6b1b',
    messagingSenderId: '269246041090',
    projectId: 'e-note-35bda',
    storageBucket: 'e-note-35bda.appspot.com',
    iosClientId: '269246041090-fa71b54fhb5ersbs4mv4tjjrqt6u1ov0.apps.googleusercontent.com',
    iosBundleId: 'com.example.eNote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDw-5ASaTIHIKznE_gVykJ_lt-11iMpSk',
    appId: '1:269246041090:ios:4b0f7514656525a32f6b1b',
    messagingSenderId: '269246041090',
    projectId: 'e-note-35bda',
    storageBucket: 'e-note-35bda.appspot.com',
    iosClientId: '269246041090-fa71b54fhb5ersbs4mv4tjjrqt6u1ov0.apps.googleusercontent.com',
    iosBundleId: 'com.example.eNote',
  );
}