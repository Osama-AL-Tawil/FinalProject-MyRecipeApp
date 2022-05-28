import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function press;
  final double? height;
  final double? borderRadius;
  Color? textColor;
  Color? backgroundColor;

  ButtonWidget({Key? key,
    required this.label,
    required this.press,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
    this.height = 55,
    this.borderRadius = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:55, //height of button
      width:MediaQuery.of(context).size.width- 7.w, //width of button
      child: ElevatedButton(
        onPressed: () { press(); },
        child:Text(label,style:  TextStyle(fontSize:11.sp,color: textColor)),
        style: ElevatedButton.styleFrom(shape: const StadiumBorder(),primary: backgroundColor),

      ),);





      //
    // return   Material(
    //   color: primaryColor,
    //   borderRadius: BorderRadius.circular(50),
    //   child: InkWell(
    //     onTap: press(),
    //     borderRadius: BorderRadius.circular(50),
    //     child: Container(
    //       width: MediaQuery.of(context).size.width-30,
    //       height: 55,
    //       alignment: Alignment.center,
    //       child: Text(label,style: const TextStyle(fontSize: 16,color: whiteColor,fontWeight: FontWeight.bold)),
    //     ),
    //   ),
    // );

  }
}
