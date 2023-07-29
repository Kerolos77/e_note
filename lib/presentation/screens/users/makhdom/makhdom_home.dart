import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note/presentation/screens/users/makhdom/makhdom_kraat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';
import 'makhdom_attend.dart';
import 'makhdom_manaheg.dart';
import 'marathon.dart';

class MakhdomHome extends StatefulWidget {
  const MakhdomHome({Key? key}) : super(key: key);

  @override
  State<MakhdomHome> createState() => _MakhdomHomeState();
}

class _MakhdomHomeState extends State<MakhdomHome> {
  var screens = [
    const MakhdomManaheg(),
    const MakhdomMarathon(),
    const MakhdomKraat(),
    const MakhdomAttend(),
  ];
  var screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
              color: Colors.green,
            ),
          )
        ],
      ),
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
              FontAwesomeIcons.bookBible,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.add,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.fingerprint,
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

  void logout() {
    FirebaseAuth.instance.signOut();
    showToast(
      message: 'Log out Successfully',
    );
    CacheHelper.removeData(key: "user");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(),
        ));
  }
}
