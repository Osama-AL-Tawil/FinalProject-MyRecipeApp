import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/models/favorite_s_model.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/screens/recipe_details_page.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/text_widget.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';

class FavoriteListItem extends StatelessWidget {
  FavoriteSModel favorite;
  Function onPressed;
  FavoriteListItem({Key? key,required this.favorite,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cornerRadius = 6;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeDetailsPage(favorite.recipe)));
        },
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
                    image: favorite.recipe.image.url ,
                    placeholder:'assets/d_placeholder.png' ,
                    width: width,
                    height: 18.h,
                    fit: BoxFit.cover,
                  )

                ),
                Positioned(
                    top: 6,
                    right: 7,
                    child: SizedBox(
                      width: width,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: [
                              SvgPicture.asset('assets/ic_favorites_o.svg', height: 3.h, width: 3.h),
                              Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        hoverColor: const Color(0x40000000),
                                        onTap: () {onPressed();},
                                      )))
                            ],
                          )),
                    )),
              ],
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 8),
                child: TextCWidget(
                  text:favorite.recipe.title,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 1, bottom: 2),
                child: TextCWidget(text:
                  favorite.recipe.description,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: grayColor,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                ),
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
