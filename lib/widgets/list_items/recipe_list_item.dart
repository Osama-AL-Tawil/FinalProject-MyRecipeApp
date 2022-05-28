import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/screens/recipe_details_page.dart';
import 'package:recipes_project/widgets/text_widget.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';

class RecipeListItem extends StatelessWidget {
  final bool isHome;
  RecipeModel? recipe;
  Function onClick;
   RecipeListItem({Key? key,required this.isHome,this.recipe,required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cornerRadius = 6;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeDetailsPage(recipe!)));
        },
        borderRadius: BorderRadius.circular(cornerRadius),
        hoverColor: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                    topRight: Radius.circular(cornerRadius),
                  ),
                  child:FadeInImage.assetNetwork(
                    image: recipe!.image.url ,
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
                              isHome&&recipe!.inFavorite==false? SvgPicture.asset('assets/ic_favorite_w.svg', height: 2.h, width: 2.h)
                                  :SvgPicture.asset('assets/ic_favorites_o.svg', height: 3.h, width: 3.h),
                              Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        hoverColor: const Color(0x40000000),
                                        onTap: () {
                                          onClick();
                                        },
                                      )))
                            ],
                          )),
                    )),
              ],
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child:TextCWidget(text: recipe!.title,style:
                 TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),maxLines: 1, )

              ),
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 1, bottom: 2),
                child: TextCWidget(text:
                  recipe!.description,
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
