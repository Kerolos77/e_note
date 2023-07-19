import 'package:e_note/presentation/screens/users/admin/attendance.dart';
import 'package:e_note/presentation/screens/users/admin/manaheg.dart';
import 'package:e_note/presentation/screens/users/makhdom/makhdom_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/regidtration_cubit/registration_cubit.dart';
import '../../business_logic/cubit/regidtration_cubit/registration_states.dart';
import '../../data/local/cache_helper.dart';
import '../widgets/global/logo.dart';
import '../widgets/global/toast.dart';
import '../widgets/registration/login_container.dart';
import '../widgets/registration/registration_background.dart';
import '../widgets/registration/registration_text.dart';
import '../widgets/registration/sign_up_container.dart';

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController teamIdController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    // emailController.text = 'david.ashraf@gmail.com';
    // passwordController.text = '12345678';
    emailController.text = 'manaheg@gmail.com';
    passwordController.text = '1WP935UR';
    confirmPasswordController.text = '12345678';
    firstNameController.text = 'david';
    lastNameController.text = 'ashraf';
    teamIdController.text = '12345678';

    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (BuildContext context, RegistrationState state) {
          if (state is LoginLoadingRegistrationState ||
              state is SignUpLoadingRegistrationState) {
            flag = true;
          }
          if (state is LoginErrorRegistrationState) {
            flag = false;
            showToast(
              message: state.error,
            );
          }
          if (state is LoginSuccessRegistrationState) {
            if (emailController.text == 'manaheg@gmail.com') {
              CacheHelper.putData(key: "user", value: 'manaheg').then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Manaheg(),
                    ));
              });
            } else if (emailController.text == 'attendance@gmail.com') {
              CacheHelper.putData(key: "user", value: 'attendance')
                  .then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Attendance(),
                    ));
              });
            } else {
              CacheHelper.putData(key: "user", value: state.uid).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakhdomHome(),
                    ));
              });
            }
            flag = false;
            showToast(
              message: "you are welcome",
            );
          }
          if (state is SignUpErrorRegistrationState) {
            flag = false;
            showToast(
              message: state.error,
            );
          }
          if (state is SignUpSuccessRegistrationState) {
            flag = false;
            showToast(
              message: "Sign up Successfully",
            );
          }
        },
        builder: (BuildContext context, RegistrationState state) {
          RegistrationCubit cub = RegistrationCubit.get(context);
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    registrationBackground(context: context),
                    Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 9,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: logo(size: 100),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        registrationText(
                                            text: 'Sign Up',
                                            isClick: !cub.registrationFlag,
                                            onTap: () {
                                              cub.changeRegistration(false);
                                            }),
                                        registrationText(
                                            text: 'Login',
                                            isClick: cub.registrationFlag,
                                            onTap: () {
                                              cub.changeRegistration(true);
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.passthrough,
                                      children: [
                                        cub.registrationFlag
                                            ? loginContainer(
                                                flag: flag,
                                                formKey: formKey,
                                                onTap: () {
                                                  print(
                                                      '----------------------${formKey.currentState}');
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cub.login(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        buildContext: context);
                                                  }
                                                },
                                                context: context,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController)
                                            : signUpContainer(
                                                formKey: formKey,
                                                flag: flag,
                                                onTap: () {
                                                  print(
                                                      '----------------------${formKey.currentState}');
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cub.signUp(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      firstName:
                                                          firstNameController
                                                              .text,
                                                      lastName:
                                                          lastNameController
                                                              .text,
                                                      gender: cub.envFlag
                                                          ? 'Female'
                                                          : 'Male',
                                                      birthDate:
                                                          birthDateController
                                                              .text,
                                                      teamId:
                                                          teamIdController.text,
                                                      userType: emailController
                                                              .text
                                                              .contains(
                                                                  '.khadem')
                                                          ? 'khadem'
                                                          : 'user',
                                                    );
                                                  }
                                                },
                                                onToggle: (value) {
                                                  cub.changeEnvFlag(value);
                                                },
                                                state: cub.envFlag,
                                                context: context,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController,
                                                confirmPasswordController:
                                                    confirmPasswordController,
                                                firstNameController:
                                                    firstNameController,
                                                lastNameController:
                                                    lastNameController,
                                                birthDateController:
                                                    birthDateController,
                                                teamIdController:
                                                    teamIdController,
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
          );
        },
      ),
    );
  }
}
