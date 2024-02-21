import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../global/default_button.dart';
import '../global/default_loading.dart';
import '../global/default_text_field.dart';

Widget loginContainer({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController payIdController,
  required GestureTapCallback onTap,
  required Key formKey,
  required BuildContext context,
  required bool flag,
}) {
  return Form(
    key: formKey,
    child: SizedBox(
      child: Column(
        children: [
          DefaultTextField(
            control: emailController,
            text: 'E-mail',
            type: TextInputType.emailAddress,
            validate: (value) {
              if (value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          DefaultTextField(
              isPassword: true,
              control: passwordController,
              text: 'Password',
              type: TextInputType.emailAddress,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          ConditionalBuilder(
            condition: (!flag),
            builder: (BuildContext context) => defaultButton(
                width: MediaQuery.of(context).size.width,
                text: "Login",
                onPressed: onTap),
            fallback: (BuildContext context) => defaultLoading(),
          ),
        ],
      ),
    ),
  );
}
