import 'package:e_note/presentation/screens/users/makhdom/makhdom_home.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/regidtration/registration_cubit.dart';
import '../../business_logic/cubit/regidtration/registration_states.dart';
import '../../data/local/cache_helper.dart';
import '../widgets/global/default_snack_bar.dart';
import '../widgets/global/logo.dart';
import '../widgets/registration/login_container.dart';
import '../widgets/registration/registration_background.dart';
import '../widgets/registration/registration_text.dart';
import '../widgets/registration/sign_up_container.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController birthDateController = TextEditingController();

  TextEditingController teamIdController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  TextEditingController payIdController = TextEditingController();

  EmailOTP emailOTP = EmailOTP();

  var formKey = GlobalKey<FormState>();

  bool flag = false;

  bool otpFlag = false;
  late EmailAuth emailAuth;

  // @override
  // void initState() {
  //   super.initState();
  //   emailAuth = EmailAuth(sessionName: 'new session');
  //   emailAuth.config(remoteServerConfiguration);
  // }

  @override
  Widget build(BuildContext context) {
    // Mmina@12345
    // minaeskander256.me@gmail.com
    // emailController.text = 'kokofaie7@gmail.com';
    // passwordController.text = '12345678';
    // confirmPasswordController.text = '12345678';
    // fullNameController.text = 'koko faie';
    //
    // teamIdController.text = '12345678';
    // payIdController.text = 'V6I0QXTBWTICVOVNRPZ1';

    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (BuildContext context, RegistrationState state) {
          if (state is UserTypeNotAllowedRegistrationState) {
            flag = false;
            logout();
            defaultSnackBar(
                message: "User Not Exist OR try to use E-Note Khadem APP",
                context: context);
          }
          if (state is LoginLoadingRegistrationState ||
              state is SignUpLoadingRegistrationState) {
            flag = true;
          }
          if (state is LoginErrorRegistrationState) {
            flag = false;
            print(state.error);
            defaultSnackBar(message: state.error, context: context);
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
            defaultSnackBar(message: "you are welcome", context: context);
          }
          if (state is SignUpErrorRegistrationState) {
            flag = false;
            print(state.error);
            defaultSnackBar(message: state.error, context: context);
          }
          if (state is SignUpSuccessRegistrationState) {
            flag = false;

            defaultSnackBar(message: "Sign up Successfully", context: context);
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
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    );
                                                  }
                                                },
                                                context: context,
                                                emailController:
                                                    emailController,
                                                passwordController:
                                                    passwordController,
                                                payIdController:
                                                    payIdController,
                                              )
                                            : signUpContainer(
                                          formKey: formKey,
                                                flag: flag,
                                                onPressed: () {
                                                  if (true) {
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
                                                          userType: 'user',
                                                          payId: payIdController
                                                              .text);
                                                    }
                                                  } else {
                                                    defaultSnackBar(
                                                        message:
                                                            'please Verify Your Email',
                                                        context: context);
                                                  }
                                                },
                                                verifyOnPressed: () {},
                                                // verifyOnPressed: () async {
                                                //         var res =
                                                //             await emailAuth.sendOtp(
                                                //           recipientMail:
                                                //               emailController.text,
                                                //           otpLength: 6,
                                                //         );
                                                //
                                                //         if (res) {
                                                //           showDialog(
                                                //               context: context,
                                                //               builder: (BuildContext
                                                //                   context) {
                                                //                 return Dialog(
                                                //                   child: Column(
                                                //                     mainAxisSize:
                                                //                         MainAxisSize
                                                //                             .min,
                                                //                     children: [
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets
                                                //                                     .all(
                                                //                                 8.0),
                                                //                         child: TextFormField(
                                                //                             onTap: () {
                                                //                               otpController
                                                //                                   .clear();
                                                //                             },
                                                //                             controller: otpController,
                                                //                             decoration: const InputDecoration(hintText: "Enter OTP")),
                                                //                       ),
                                                //                 defaultText(
                                                //                     text:
                                                //                               'we sent you an email please enter the OTP',
                                                //                           size: 10),
                                                //                 ElevatedButton(
                                                //                     onPressed:
                                                //                         () async {
                                                //                             var res = await emailAuth.validateOtp(
                                                //                                 recipientMail: emailController
                                                //                                     .text,
                                                //                                 userOtp:
                                                //                                     otpController.text);
                                                //                             if (res) {
                                                //                               Navigator.of(context)
                                                //                                   .pop();
                                                //                               ScaffoldMessenger.of(context)
                                                //                                   .showSnackBar(const SnackBar(
                                                //                                 content:
                                                //                                     Text("Email is verified"),
                                                //                               ));
                                                //                               otpFlag =
                                                //                                   true;
                                                //                             } else {
                                                //                         otpFlag =
                                                //                                   false;
                                                //                               otpController.text =
                                                //                                   'Invaled OTP';
                                                //                             }
                                                //                     },
                                                //                     child: const Text(
                                                //                         "Verify")),
                                                //               ],
                                                //             ),
                                                //           );
                                                //         });
                                                //         } else {
                                                //           ScaffoldMessenger.of(
                                                //                   context)
                                                //               .showSnackBar(
                                                //                   const SnackBar(
                                                //             content: Text(
                                                //                 "Oops, OTP send failed"),
                                                //           ));
                                                //         }
                                                //       },
                                                // verifyOnPressed: () async {
                                                //   emailOTP.setConfig(
                                                //       appEmail:
                                                //           "kirollosfayek7@gmail.com",
                                                //       appName: "Email OTP",
                                                //       userEmail:
                                                //           emailController.text,
                                                //       otpLength: 6,
                                                //       otpType:
                                                //           OTPType.digitsOnly);
                                                //   if (await emailOTP
                                                //           .sendOTP() ==
                                                //       true) {
                                                //     showDialog(
                                                //         context: context,
                                                //         builder: (BuildContext
                                                //             context) {
                                                //           return Dialog(
                                                //             child: Column(
                                                //               mainAxisSize:
                                                //                   MainAxisSize
                                                //                       .min,
                                                //               children: [
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: TextFormField(
                                                //                       onTap: () {
                                                //                         otpController
                                                //                             .clear();
                                                //                       },
                                                //                       controller: otpController,
                                                //                       decoration: const InputDecoration(hintText: "Enter OTP")),
                                                //                 ),
                                                //                 defaultText(
                                                //                     text:
                                                //                         'we sent you an email please enter the OTP',
                                                //                     size: 10),
                                                //                 ElevatedButton(
                                                //                     onPressed:
                                                //                         () async {
                                                //                       if (await emailOTP.verifyOTP(
                                                //                               otp: otpController.text) ==
                                                //                           true) {
                                                //                         Navigator.of(context)
                                                //                             .pop();
                                                //                         ScaffoldMessenger.of(context)
                                                //                             .showSnackBar(const SnackBar(
                                                //                           content:
                                                //                               Text("Email is verified"),
                                                //                         ));
                                                //                         otpFlag =
                                                //                             true;
                                                //                       } else {
                                                //                         otpFlag =
                                                //                             false;
                                                //                         otpController.text =
                                                //                             'Invaled OTP';
                                                //                       }
                                                //                     },
                                                //                     child: const Text(
                                                //                         "Verify")),
                                                //               ],
                                                //             ),
                                                //           );
                                                //         });
                                                //   } else {
                                                //     ScaffoldMessenger.of(
                                                //             context)
                                                //         .showSnackBar(
                                                //             const SnackBar(
                                                //       content: Text(
                                                //           "Oops, OTP send failed"),
                                                //     ));
                                                //   }
                                                // },
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

  void logout() {
    FirebaseAuth.instance.signOut();
    CacheHelper.removeData(key: "user");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(),
        ));
  }
}
