import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/users/admin/admin_cubit.dart';
import '../../../../business_logic/cubit/users/admin/admin_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/default_text/default_text.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (BuildContext context, AdminStates state) {
      if (state is LogOutSuccessAdminState) {
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
    }, builder: (BuildContext context, AdminStates state) {
      AdminCubit AdminCube = AdminCubit.get(context);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                AdminCube.logout();
              },
              icon: const Icon(
                FontAwesomeIcons.signOutAlt,
                size: 20,
                color: Colors.green,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: DoubleBackToCloseApp(
              snackBar: SnackBar(
                content: defaultText(text: 'Tap back again to leave'),
              ),
              child: Center(
                child: defaultText(text: 'ADMIN', color: Colors.black),
              ),
            ),
          ),
        ),
      );
    });
  }
}
