import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({Key? key}) : super(key: key);

  static const _backgroundColor = Color(0xFFFFFFFF);

  static const _colors = [
    Color(0x802F80ED),
    Color(0xBF2F80ED),
    Color(0xFF2F80ED),
  ];

  static const _durations = [
    11000,
    10500,
    10000,
  ];

  static const _heightPercentages = [
    0.56,
    0.61,
    0.66,
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 2,
          child: WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: _backgroundColor,
            size: Size(w, h / 2),
            heightPercentage: 0.51,
            waveAmplitude: 5,
          ),
        ),
        WaveWidget(
          config: CustomConfig(
            colors: _colors,
            durations: _durations,
            heightPercentages: _heightPercentages,
          ),
          backgroundColor: _backgroundColor,
          size: Size(w, h / 2),
          waveAmplitude: 5,
        ),
      ],
    );
  }
}
