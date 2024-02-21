import 'package:e_note/presentation/screens/regisation_screen.dart';
import 'package:e_note/presentation/screens/users/makhdom/makhdom_home.dart';
import 'package:flutter/material.dart';

import '../../../../constants/conestant.dart';
import '../widgets/global/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashTime = 4;

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashTime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        Widget widget;
        if (constUid != null && constUid != '') {
          widget = const MakhdomHome();
        } else {
          widget = Registration();
        }
        return widget;
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: logo(size: 200)),
    );
  }
}
