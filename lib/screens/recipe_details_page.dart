import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:recipes_project/screens/show_user_recipes.dart';
import 'package:recipes_project/widgets/text_widget.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';
import '../firebase/firestore_repository.dart';
class RecipeDetailsPage extends StatefulWidget {
  RecipeModel recipeData;
  RecipeDetailsPage(this.recipeData,{Key? key}) : super(key: key);

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: user!=null?SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      FadeInImage(
                          placeholder: const AssetImage(assetPlaceholder),
                          image: NetworkImage(widget.recipeData.image.url,),
                          width: MediaQuery.of(context).size.width,
                          height: 400, fit: BoxFit.fill
                      ),
                      Positioned(
                          top: 4.h,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
                                ),
                                const Text('Back',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                                Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      IconButton(
                                      icon:SvgPicture.asset('assets/ic_favorites_o.svg')
                                      ,onPressed: (){addToFavorite(context,widget.recipeData.id);},)],

                                    )),
                                SizedBox(
                                  width: 2.w,
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          top: 35.h,
                          child: SvgPicture.asset('assets/image_shadow.svg',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth))
                    ],
                  ),
                ),
                Container(margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                   SizedBox(width:MediaQuery.of(context).size.width
                       , child:  TextCWidget(text:widget.recipeData.title,
                       style: TextStyle(fontSize: 20.sp))),  //Title
                    const SizedBox(height: 10),
                     Card(color:const Color(0x9AF5F5F5),elevation:0,
                     child: Padding(padding: const EdgeInsets.all(10),
                       child: Row(children: [
                         user!.profileImage!=null&&user!.profileImage!=''?
                         CircleAvatar(backgroundImage: NetworkImage(user!.profileImage!),radius: 30,)
                             :const CircleAvatar(backgroundImage: AssetImage(profilePlaceholder),radius: 30,),
                         const SizedBox(width: 10,),
                         Column(
                           crossAxisAlignment:CrossAxisAlignment.start,
                           children: [
                           Text(user!.userName,style: const TextStyle(fontWeight: FontWeight.bold),),
                           Text(user!.email,style: const TextStyle(fontSize: 10,color: Colors.grey),),
                         ],),
                         const SizedBox(width: 10,),
                         Expanded(child:
                         Row(
                             mainAxisAlignment:MainAxisAlignment.end,
                             children: [OutlinedButton(
                                 onPressed: (){
                                   Navigator.of(context).push(MaterialPageRoute(builder:
                                       (context)=>ShowUserRecipes(widget.recipeData.userId,user!)));
                                 },
                                 child: const Text('Show All',style: TextStyle(fontSize: 11),))
                             ] ))

                       ],),),),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[ Text(
                                    'Category:'+widget.recipeData.category['name'].toString(),
                                    style: TextStyle(fontSize: 8.sp),
                                  )])),
                          SizedBox(width: 2.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextCWidget(text:widget.recipeData.description),
                    SizedBox(height: 4.h),
                  ],)
                  ,)


              ],
            ))
            :Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)
    );
  }
  getUserData(BuildContext context)async{
   user ??= await FirestoreRepository(context).getUserData(widget.recipeData.userId);
   log(user.toString());
   setState(() {});
  }
  addToFavorite(BuildContext context,String recipeId) async{
    await FirestoreRepository(context).addToFavorite(recipeId);
  }
}

// class RecipeDetailsPage extends StatelessWidget {
//   RecipeModel recipeData;
//   RecipeDetailsPage(this.recipeData,{Key? key}) : super(key: key);
//   UserModel? user;
//
//   @override
//   Widget build(BuildContext context) {
//     getUserData(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: user!=null?SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 400,
//             child: Stack(
//               children: [
//                 Image.network(
//                   recipeData.image.url,
//                   width: MediaQuery.of(context).size.width,
//                   height: 400,
//                   fit: BoxFit.fill,
//                 ),
//                 //SizedBox(,)
//                 Positioned(
//                     top: 4.h,
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: const Icon(Icons.arrow_back_ios),
//                           ),
//                           const Text('Back',style: TextStyle(fontWeight: FontWeight.w600),),
//                           Expanded(
//                               child: Align(
//                             alignment: Alignment.centerRight,
//                             child:
//                                IconButton(
//                                  icon:SvgPicture.asset('assets/ic_favorites_o.svg')
//                                  ,onPressed: (){addToFavorite(context, recipeData.id);},),
//                           )),
//                           SizedBox(
//                             width: 2.w,
//                           )
//                         ],
//                       ),
//                     )),
//                 Positioned(
//                     top: 35.h,
//                     child: SvgPicture.asset('assets/image_shadow.svg',
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.fitWidth))
//               ],
//             ),
//           ),
//           SizedBox(height: 15),
//
//           Padding(
//             padding: EdgeInsets.only(left: 2.w),
//             child: Text(recipeData.title,
//                 style: TextStyle(fontSize: 20.sp),textAlign: TextAlign.start),
//           ),  //Title
//           SizedBox(height: 10),
//
//           Card(color:Color(0x9AF5F5F5),elevation:0,child: Padding(padding: EdgeInsets.all(10),child: Row(children: [
//             CircleAvatar(backgroundImage: AssetImage(profilePlaceholder),radius: 30,),
//             SizedBox(width: 10,),
//             Text('Osama',style: const TextStyle(fontWeight: FontWeight.bold),),
//             SizedBox(width: 10,),
//             Expanded(child:
//             Row(
//                 mainAxisAlignment:MainAxisAlignment.end,
//                 children: [OutlinedButton(onPressed: (){},
//                     child: Text('Show All',style: TextStyle(fontSize: 11),))
//                 ] ))
//
//           ],),),),
//           SizedBox(height: 2.h),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               children: [
//                 SizedBox(width: 2.w),
//                 Text(
//                   'DESCRIPTION',
//                   style: TextStyle(fontSize: 10.sp),
//                 ),
//                 Expanded(
//                     child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Category:'+recipeData.category['name'].toString(),
//                           style: TextStyle(fontSize: 8.sp),
//                         ))),
//                 SizedBox(width: 2.w),
//               ],
//             ),
//           ),
//           SizedBox(height: 2.h),
//           Padding(
//             padding: EdgeInsets.only(left: 2.w, right: 2.w),
//             child: Text(recipeData.description, textAlign: TextAlign.left),
//           )
//         ],
//       ))
//           :Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)
//     );
//   }
//   getUserData(BuildContext context)async{
//     user ??= await FirestoreRepository(context).getUserData(recipeData.userId);
//   }
//   addToFavorite(BuildContext context,String recipeId) async{
//     await FirestoreRepository(context).addToFavorite(recipeId);
//   }
// }
