import 'package:flutter/material.dart';
import 'package:recipes_project/models/category_model.dart';
import 'package:recipes_project/screens/category_details.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';
import '../colors.dart';

class CategoryListItem extends StatelessWidget {
   CategoryModel category;
   CategoryListItem( this.category,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double borderRadius = 6;
    return Card(
      child:
      Stack(alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(
              category.imageData.url,
              width: width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(color:const Color(0x40000000),),
          ),
          Padding(padding: const EdgeInsets.only(left: 1,right: 1),
              child:Text(category.name.en!,style: TextStyle(fontSize: 14.sp,color: whiteColor,fontWeight: FontWeight.w600,fontFamily: 'Cairo'),textAlign: TextAlign.center,),),
          Positioned.fill(
              child:  Material(
                  color: Colors.transparent,
                  child:  InkWell(
                    borderRadius: BorderRadius.circular(borderRadius),
                    hoverColor: const Color(0x40000000),
                    onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          CategoryDetailsPage(category.name.en!,category.id!)));
                    },
                  ))),
        ],
      ),
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}
