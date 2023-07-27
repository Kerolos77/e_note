import 'package:e_note/presentation/screens/regisation_screen.dart';
import 'package:e_note/presentation/screens/users/admin/attendance.dart';
import 'package:e_note/presentation/screens/users/admin/manaheg.dart';
import 'package:e_note/presentation/screens/users/khadem/khadem_home.dart';
import 'package:e_note/presentation/screens/users/makhdom/makhdom_home.dart';
import 'package:flutter/material.dart';

import '../../constants/conestant.dart';
import '../widgets/global/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashTime = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashTime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        Widget widget;
        if (constUid != null && constUid != '') {
          if (constUid == 'manaheg') {
            widget = const Manaheg();
          } else if (constUid == 'attendance') {
            widget = const Attendance();
          } else if (userType == 'khadem') {
            widget = const KhademHome();
          } else {
            widget = const MakhdomHome();
          }
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
