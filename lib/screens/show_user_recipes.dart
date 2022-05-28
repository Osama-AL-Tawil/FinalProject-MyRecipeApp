import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/app_constants.dart';
import 'package:recipes_project/firebase/auth_repository.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/widgets/custom_widget/refresh_widget.dart';

import '../../firebase/firestore_repository.dart';
import '../../helpers/SilverGridFixedHeight.dart';
import '../../models/recipe_model.dart';
import '../../widgets/list_items/recipe_list_item.dart';

class ShowUserRecipes extends StatefulWidget {
  final String userId;
  final UserModel user;
  const ShowUserRecipes(this.userId,this.user,{Key? key}) : super(key: key);

  @override
  State<ShowUserRecipes> createState() => _ShowUserRecipesState();
}

class _ShowUserRecipesState extends State<ShowUserRecipes> {
  List<RecipeModel>? data ;
@override
  void initState() {
    super.initState();
    getUserRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.user.userName),
        backgroundColor: primaryColor,
      ),
      body: RefreshWidget(
          mainWidget:  GridView.builder(
            itemCount:data==null?0:data!.length,
            itemBuilder: (context,index)=>RecipeListItem(isHome:true,recipe:data![index]
              ,onClick: (){addToFavorite(data![index].id.toString());},),
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 2,
                height:250
            ),

          ), onRefresh: onRefresh, data: data) ,
    );

  }

  getUserRecipes()async{
    data ??= await FirestoreRepository(context).getRecipes(userId: widget.userId);
    setState(() {});
  }

  Future<void> onRefresh() async {
   setState(() {});
  }

  addToFavorite(String recipeId) async{
   final isAuth = AuthRepository(context).checkUserIfAuth();
   if(isAuth){
     await FirestoreRepository(context).addToFavorite(recipeId);
   }
  }


}

