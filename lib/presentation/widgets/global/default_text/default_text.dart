import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultText({
  required String text,
  double size = 15,
  Color color = Colors.black,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
        fontSize: size, color: color, fontWeight: FontWeight.w500),
  );
}