import 'package:flutter/material.dart';

import 'default_text.dart';

Widget defaultButton({
  required String text,
  required bool isDone,
  VoidCallback? onPress,
  required BuildContext context,
  Color color = Colors.green,
  String? imagePath,
}) =>
    Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isDone ? color : Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
        child: MaterialButton(
            onPressed: isDone ? onPress : () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagePath != null
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          imagePath,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                defaultText(
                  text: text,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            )),
      ),
    );
