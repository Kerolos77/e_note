import 'package:flutter/material.dart';


Widget defaultTextFiled(
    {required TextEditingController control,
      required TextInputType type,
      required String hint,
      bool obscure = false,
      IconData? prefixIcon,
      IconData? suffixIcon,
      bool readOnly = false,
      FocusNode? focusNode,
      ValueChanged? onSubmit,
      ValueChanged? onchange,
      VoidCallback? onPressSuffixIcon,
      GestureTapCallback? onTape,
      FormFieldValidator? validate,
      Color iconColor = Colors.black,
      // String? text,
    }) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      color: Colors.blue.shade50,
      child: TextFormField(
        obscureText: obscure,
        // initialValue: text,
        focusNode: focusNode,
        controller: control,
        keyboardType: type,
        onChanged: onchange,
        onTap: onTape,
        validator: validate,
        onFieldSubmitted: onSubmit,
        cursorColor: Colors.black,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 15,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          prefixIcon:Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon:IconButton(
            icon: Icon(
              suffixIcon,
              color: iconColor,
            ),
            onPressed: onPressSuffixIcon,
          ),
        ),
      ),
    );