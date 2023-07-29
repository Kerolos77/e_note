import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note/presentation/screens/users/khadem/view_marathon_team.dart';
import 'package:e_note/presentation/screens/users/khadem/view_team_attend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';
import 'view_kraat_team.dart';

class KhademHome extends StatefulWidget {
  const KhademHome({Key? key}) : super(key: key);

  @override
  State<KhademHome> createState() => _KhademHomeState();
}

class _KhademHomeState extends State<KhademHome> {
  var screens = [
    const ViewKraatTeam(),
    const ViewTeamMaraton(),
    const ViewTeamAttend(),
  ];
  var screenIndex = 0;

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
              FontAwesomeIcons.file,
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
