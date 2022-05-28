import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final String? description;
  final String iconPath;
  final bool withArrow;
  final Function? pressed;
  const ProfileWidget({Key? key,this.pressed, required this.title, this.description, required this.iconPath,this.withArrow=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double borderRadius=17;
    return Card(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius)
    ),elevation: 1,
        child:
    InkWell(borderRadius:BorderRadius.circular(borderRadius),hoverColor:grayColor,onTap: (){pressed!=null?pressed!():null;},child:
        Padding(padding: EdgeInsets.all(3.5.w),child:SizedBox(width: width,child: Row(children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 3.w,),
          description!=null?
          Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
            Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 1.h,),
            Text(description!,style: const TextStyle(color: grayColor),),
          ],): Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
          withArrow?Expanded(child: Align(alignment:Alignment.centerRight,child: SvgPicture.asset('assets/ic_arrow_black.svg'))):const SizedBox()

        ],),)),


    ));
  }
}
