import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double area = w * h;
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: w / 8,
      numberOfParticles: area / 1500,
      speedOfParticles: 0.7,
      height: h,
      width: w,
      onTapAnimation: true,
      particleColor: const Color(0xFF2F80ED),
      awayAnimationDuration: const Duration(milliseconds: 600),
      maxParticleSize: 6,
      isRandSize: true,
      isRandomColor: true,
      randColorList: const [
        Color(0xFF2F80ED),
      ],
      awayAnimationCurve: Curves.easeInOutBack,
      // connectDots: true, //not recommended
    );
  }
}
