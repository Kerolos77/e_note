import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultTextField({
  required TextEditingController control,
  required TextInputType type,
  required String text,
  bool readOnly = false,
  bool obscure = false,
  ValueChanged? onSubmit,
  ValueChanged? onchange,
  GestureTapCallback? onTape,
  FormFieldValidator? validate,
  Color iconColor = Colors.black,
  var maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: defaultText(text: text, size: 14)),
      TextFormField(
        readOnly: readOnly,
        controller: control,
        keyboardType: type,
        obscureText: obscure,
        onChanged: onchange,
        onTap: onTape,
        validator: validate,
        maxLines: maxLines,
        onFieldSubmitted: onSubmit,
        cursorColor: Colors.black,
        style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color.fromRGBO(147, 147, 147, 1),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color.fromRGBO(147, 147, 147, 1),
              width: 1.0,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ),
    ],
  );
}
