import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipes_project/models/favorite_s_model.dart';
import 'package:recipes_project/models/image_model.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/models/trans_name_model.dart';
import 'package:recipes_project/models/user_model.dart';

import '../firebase/firestore_repository.dart';
import '../models/category_model.dart';

class MainProvider extends ChangeNotifier{

  List<CategoryModel>? categories ;
  List<RecipeModel>? myRecipe;
  List<RecipeModel>? homeList;
  List<FavoriteSModel>? favoriteList;
  UserModel? user;

  refreshUserData(UserModel userModel){
    user=userModel;
    notifyListeners();
  }
  getUserData(BuildContext context,String userId) async{
    user= await FirestoreRepository(context).getUserData(userId);
    notifyListeners();
  }
  
  //refresh when add new recipe
  refreshHome(RecipeModel data)async{
      homeList!.add(data);
      notifyListeners();
  }  //refresh when add new recipe


   //get categories
  getCategories(BuildContext context) async{
    if(categories!=null){
      categories=null;
      notifyListeners();
    }
    await FirestoreRepository(context).getCategories().then((value) =>categories=value );
    notifyListeners();
  }

  //refresh when add new recipe
  refreshCategory(CategoryModel data)async{
    //getCategories(context);
    //categories!.add(data);
    //notifyListeners();
  }

  // get my recipe
  getMyRecipeList(BuildContext context,String userId)async{
    if(myRecipe!=null){
      myRecipe=null;
      notifyListeners();
    }
    final data = await FirestoreRepository(context).getRecipes(userId: userId);
    myRecipe=data;
    log(data.toString());
    notifyListeners();
  }

  removeRecipe(BuildContext context,String recipeId) {
    FirestoreRepository(context).removeRecipe(recipeId);
    myRecipe!.removeWhere((element) => element.id == recipeId);
    homeList!.removeWhere((element) => element.id == recipeId);
    notifyListeners();
  }

  refreshMyRecipeList(RecipeModel recipeModel){
     myRecipe!.removeWhere((element) => element.id==recipeModel.id);
     myRecipe!.add(recipeModel);
     notifyListeners();
  }

  getHomeData(BuildContext context)async{
    if(homeList!=null){
      homeList=null;
      notifyListeners();
    }
    final data = await FirestoreRepository(context).getRecipes();
    homeList=data;
    notifyListeners();
  }

  getFavorite(BuildContext context)async{
    if(favoriteList!=null){
      favoriteList=null;
      notifyListeners();
    }
    final data = await FirestoreRepository(context).getFavorite();
    favoriteList=data;
    notifyListeners();
  }

  homeAddToFavorite(String recipeId){
    final item =  homeList!.firstWhere((element) => element.id==recipeId);
    item.inFavorite=true;
    favoriteList!.add(FavoriteSModel(item.id, item));
    notifyListeners();
  }

  homeRemoveFromFavorite(String recipeId){
    final item =  homeList!.firstWhere((element) => element.id==recipeId);
    item.inFavorite=false;
    favoriteList!.removeWhere((element) => element.recipe.id==recipeId);
    notifyListeners();
  }


  removeFromFavorite(BuildContext context,String docId) async{
    await FirestoreRepository(context).removeFromFavorite(docId);
    favoriteList!.removeWhere((element) => element.docId==docId);
    notifyListeners();
  }

  removeAllData(){
    categories=null;
    myRecipe=null;
    homeList=null;
    favoriteList=null;
    user=null;
  }



}