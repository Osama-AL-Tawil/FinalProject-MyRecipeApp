import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Function onPressed;

  const OutlineButtonWidget(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.borderColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width - 7.w,
      child: OutlinedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(label),
        style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const StadiumBorder(),
            side: BorderSide(color: borderColor)),
      ),
    );
  }
}
