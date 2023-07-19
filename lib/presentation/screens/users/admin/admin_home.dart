import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/users/admin/admin_cubit.dart';
import 'admin.dart';
import 'attendance.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var screens = [
    BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: const Admin(),
    ),
    const Attendance(),
  ];
  var screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.user,
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
