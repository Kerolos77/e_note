import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../constants/colors.dart';
import '../global/default_text/default_text.dart';

Widget keraatRow({
  required bool state,
  required String text,
  required Function(bool) onToggle,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlutterSwitch(
          value: state,
          borderRadius: 20.0,
          padding: 5.0,
          toggleSize: 10,
          height: 20,
          width: 40,
          activeColor: ConstColors.primaryColor,
          inactiveColor: ConstColors.grey,
          onToggle: onToggle,
        ),
        defaultText(
          text: text,
          size: 18.0,
        ),
      ],
    ),
  );
}
