import 'package:e_note/presentation/screens/users/makhdom/makhdom_home.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/regidtration/registration_cubit.dart';
import '../../business_logic/cubit/regidtration/registration_states.dart';
import '../../data/local/cache_helper.dart';
import '../widgets/global/default_text/default_text.dart';
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
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController teamIdController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  EmailOTP emailOTP = EmailOTP();
  var formKey = GlobalKey<FormState>();
  bool flag = false;
  bool otpFlag = false;

  @override
  Widget build(BuildContext context) {
    // emailController.text = 'david.ashraf@gmail.com';
    // passwordController.text = '12345678';
    // confirmPasswordController.text = '12345678';
    // firstNameController.text = 'david';
    // lastNameController.text = 'ashraf';
    // teamIdController.text = '12345678';

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
              CacheHelper.putData(key: 'userType', value: 'makhdom');
              CacheHelper.putData(key: "user", value: state.uid).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakhdomHome(),
                    ));
              });

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
                                                onPressed: () {
                                                  print('-------1');
                                                  if (otpFlag) {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      cub.signUp(
                                                          phone: phoneController
                                                              .text,
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          fullName:
                                                              fullNameController
                                                                  .text,
                                                          gender: cub.genderFlag
                                                              ? 'Female'
                                                              : 'Male',
                                                          birthDate:
                                                              birthDateController
                                                                  .text,
                                                          teamId:
                                                              teamIdController
                                                                  .text,
                                                          userType: 'khadem');
                                                    }
                                                  } else {
                                                    showToast(
                                                        message:
                                                            'please Verify Your Email');
                                                  }
                                                },
                                                verifyOnPressed: () async {
                                                  emailOTP.setConfig(
                                                      appEmail:
                                                          "me@rohitchouhan.com",
                                                      appName: "Email OTP",
                                                      userEmail:
                                                          emailController.text,
                                                      otpLength: 6,
                                                      otpType:
                                                          OTPType.digitsOnly);
                                                  if (await emailOTP
                                                          .sendOTP() ==
                                                      true) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: TextFormField(
                                                                      onTap: () {
                                                                        otpController
                                                                            .clear();
                                                                      },
                                                                      controller: otpController,
                                                                      decoration: const InputDecoration(hintText: "Enter OTP")),
                                                                ),
                                                                defaultText(
                                                                    text:
                                                                        'we sent you an email please enter the OTP',
                                                                    size: 10),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (await emailOTP.verifyOTP(
                                                                              otp: otpController.text) ==
                                                                          true) {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("Email is verified"),
                                                                        ));
                                                                        otpFlag =
                                                                            true;
                                                                      } else {
                                                                        otpFlag =
                                                                            false;
                                                                        otpController.text =
                                                                            'Invaled OTP';
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        "Verify")),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Oops, OTP send failed"),
                                                    ));
                                                  }
                                                },
                                                onToggle: (value) {
                                                  cub.changeEnvFlag(value);
                                                },
                                                state: cub.genderFlag,
                                                context: context,
                                                phoneController:
                                                    phoneController,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController,
                                                confirmPasswordController:
                                                    confirmPasswordController,
                                                fullNameController:
                                                    fullNameController,
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
