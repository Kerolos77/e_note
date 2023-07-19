import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultText({
  required String text,
  double size = 15,
  Color color = const Color.fromRGBO(111, 111, 111, 1),
}) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        fontSize: size, color: color, fontWeight: FontWeight.w500),
  );
}