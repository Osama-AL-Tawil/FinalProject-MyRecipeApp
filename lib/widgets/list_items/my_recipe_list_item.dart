import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/widgets/text_widget.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';

class MyRecipeListItem extends StatelessWidget {
  RecipeModel recipe;
  Function onPressed;
  Function onClickDelete;
  Function onClickEdit;
  MyRecipeListItem(this.recipe,{Key? key,required this.onPressed,required this.onClickDelete,required this.onClickEdit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cornerRadius = 6;
    return Card(
      child: InkWell(
        onTap: () {onPressed();},
        borderRadius: BorderRadius.circular(cornerRadius),
        hoverColor: Colors.black,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                    topRight: Radius.circular(cornerRadius),
                  ),
                  child:FadeInImage.assetNetwork(
                    placeholder: 'assets/d_placeholder.png',
                    image:recipe.image.url ,
                    width: width,
                    height: 18.h,
                    fit: BoxFit.cover,
                  )
                ),
              ],
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 8),
                child: TextCWidget(
                 text: recipe.title,
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: TextCWidget(
                        text:recipe.description,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: grayColor,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                      ),
                    ),
                    Stack(
                      children: [
                        SvgPicture.asset('assets/ic_trash.svg',
                            height: 25, width: 25),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {onClickDelete();},
                                  hoverColor: grayColor,
                                )))
                      ],
                    ),
                    const SizedBox(width: 3,),
                    Stack(
                    children: [
                      SvgPicture.asset('assets/ic_edit.svg',
                          height: 25, width: 25),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {onClickEdit();},
                                hoverColor: grayColor,
                              )))
                    ],
                  ),
                    const SizedBox(width: 4,),


                ],),
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius)),
    );
  }
}
