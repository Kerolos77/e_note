import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note/presentation/screens/users/khadem/view_marathon_team.dart';
import 'package:e_note/presentation/screens/users/khadem/view_team_attend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KhademHome extends StatefulWidget {
  const KhademHome({Key? key}) : super(key: key);

  @override
  State<KhademHome> createState() => _KhademHomeState();
}

class _KhademHomeState extends State<KhademHome> {
  var screens = [
    const ViewTeamMaraton(),
    const ViewTeamAttend(),
  ];
  var screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
}
