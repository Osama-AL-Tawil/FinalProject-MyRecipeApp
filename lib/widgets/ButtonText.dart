import 'package:flutter/material.dart';

import '../app_constants.dart';
import 'colors.dart';

class ButtonTextWidget extends StatelessWidget {
  final String text;
  final Function press;

  const ButtonTextWidget({Key? key, required this.text, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          width: double.infinity,
          child: TextButton(
            onPressed: () => press(),
            child: Text(
              text,
              style: const TextStyle(color: grayColor),
            ),
          ),
        ));
  }
}
