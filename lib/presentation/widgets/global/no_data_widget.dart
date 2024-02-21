import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/colors.dart';
import 'default_text/default_text.dart';

Widget noData(
  double width,
  double height,
) {
  return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        const Icon(FontAwesomeIcons.notdef, color: ConstColors.primaryColor),
        const SizedBox(height: 10),
        defaultText(text: 'No Data Found'),
      ],
    ),
  );
}
