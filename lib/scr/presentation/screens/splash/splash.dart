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
              SvgPicture.asset(
                'assets/images/logo_digital.svg',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
