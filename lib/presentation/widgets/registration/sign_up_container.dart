import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_note/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../global/default_button.dart';
import '../global/default_text/default_text.dart';
import '../global/default_text_field.dart';

Widget signUpContainer({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController birthDateController,
  required TextEditingController teamIdController,
  required GestureTapCallback onTap,
  required BuildContext context,
  required void Function(bool) onToggle,
  required bool state,
  required Key formKey,
  required bool flag,
}) {
  return Form(
      key: formKey,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: defaultTextField(
                    control: firstNameController,
                    text: 'First Name',
                    type: TextInputType.name,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: defaultTextField(
                    control: lastNameController,
                    text: 'Last Name',
                    type: TextInputType.name,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            defaultText(text: 'Gender'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultText(text: 'Male', size: 20),
                FlutterSwitch(
                    value: state,
                    borderRadius: 20.0,
                    padding: 5.0,
                    activeColor: ConstColors.grey,
                    inactiveColor: ConstColors.grey,
                    onToggle: onToggle),
                defaultText(text: 'Female', size: 20),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Row(
              children: [
                Expanded(
                  child: defaultTextField(
                    control: birthDateController,
                    readOnly: true,
                    text: 'Birth Date',
                    type: TextInputType.datetime,
                    onTape: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Colors.green.shade300,
                                // header background color
                                onPrimary: Colors.black,
                                // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.black, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((date) {
                        birthDateController.text =
                            DateFormat('yyyy - MM - dd').format(date!);
                      }).catchError((error) {
                        birthDateController.text =
                            DateFormat('yyyy - MM - dd').format(DateTime.now());
                      });
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please select your Birth Date';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: defaultTextField(
                    control: teamIdController,
                    text: 'Team ID',
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Team ID';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            defaultTextField(
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
            defaultTextField(
                control: passwordController,
                text: 'Password',
                type: TextInputType.emailAddress,
                obscure: false,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            defaultTextField(
                control: confirmPasswordController,
                text: 'Confirm Password',
                type: TextInputType.emailAddress,
                obscure: false,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
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
                  text: "Sign Up",
                  onTap: onTap),
              fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ));
}
