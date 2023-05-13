import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toast({
  required String msg,
  required Color backColor,
  required Color textColor,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backColor,
      textColor: textColor,
    );