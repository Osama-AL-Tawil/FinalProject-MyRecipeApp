import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';

class ProfileWidgetC extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  const ProfileWidgetC({Key? key, required this.title, required this.description, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 2,child: Row(children: [
      SvgPicture.asset(iconPath),
      Column(children: [
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 1.h,),
        Text(description,style: const TextStyle(color: grayColor1),),
      ],),

    ],),);
  }
}
