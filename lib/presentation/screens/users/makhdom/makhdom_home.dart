import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'makhdom_attend.dart';
import 'makhdom_manaheg.dart';

class MakhdomHome extends StatefulWidget {
  const MakhdomHome({Key? key}) : super(key: key);

  @override
  State<MakhdomHome> createState() => _MakhdomHomeState();
}

class _MakhdomHomeState extends State<MakhdomHome> {
  var screens = [
    const MakhdomManaheg(),
    const MakhdomAttend(),
  ];
  var screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.filePdf,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.qrcode,
              size: 20,
            ),
            label: '',
          ),
        ],
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        currentIndex: screenIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.green,
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        elevation: 0,
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: screens[screenIndex],
      ),
    );
  }
}
