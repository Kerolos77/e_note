import 'package:e_note/scr/core/componants/defult_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/componants/background.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Background(),
          Stack(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_digital.svg',
                    width: 200,
                    height: 200,
                  ),
                  defaultButton(
                    context: context,
                    text: 'login',
                    isDone: true,
                    onPress: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
