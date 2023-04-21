import 'package:flutter/material.dart';

Widget defaultText({
  required String text,
  double size = 15,
  Color color = Colors.black,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      color: color,
    ),
  );
}