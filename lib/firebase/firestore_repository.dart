import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/firebase/storage_repository.dart';
import 'package:recipes_project/helpers/handle_message_helper.dart';
import 'package:recipes_project/helpers/toast_message.dart';
import 'package:recipes_project/helpers/shared_preferences.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/models/category_model.dart';
import 'package:recipes_project/models/favorite_model.dart';
import 'package:recipes_project/models/favorite_s_model.dart';
import 'package:recipes_project/models/image_model.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/models/trans_name_model.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../helpers/progress_dialog_builder.dart';
import '../providers/main_provider.dart';

class FirestoreRepository {
  BuildContext context;
  FirestoreRepository(this.context);

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final _storage = StorageRepository(context);
  final vHelper = ValidationHelper();
  final HandleMassageHelper _hMessage = HandleMassageHelper();
  late final HorizontalProgressAlertDialog _hDialog  =HorizontalProgressAlertDialog(context);
  final _logName = 'OS:FirebaseFirestore';
  late String userId = _auth.currentUser!.uid.toString();
  String profileImage = 'https://firebasestorage.googleapis.com/v0/b/recipe-app-d4c68.appspot.com/o/images%2Fapp%2Fd_r_image.png?alt=media&token=c4f4a338-6f2b-4fde-bcc1-df8f114f6903';


  //save user data in Firestore
  Future<void>setUserData(String userId,UserModel user)async{
     await _firestore.collection('Users').doc(userId).set(user.toMap()).then((value) => {
       SharedPreferencesHelper().saveUserData(user)
     }).catchError((e){
       _hMessage.errorMessage(e,logName: _logName);
     });
   }


  //get and save user data in shared
  Future<UserModel?> getUserData(String userId)async{
    try{
      final data =await _firestore.collection('Users').doc(userId).get();
      if(data.data()!=null){
        log('userFrom:'+ data.data().toString());
        final user = UserModel.fromMap(data.data()!);
        //SharedPreferencesHelper().saveUserData(user);
        return user;
      }
    }catch(e){
      log('userFrom:'+ e.toString());
    }
    return null;

   }


  updateUserData(UserModel user,File? image) async{

    UserModel? userModel;

    _hDialog.show(context, 'Update Profile ...');

    //upload image
    if(image!=null){
      if(user.profileImage != null && user.profileImage!=''){
        log('PROFILE IMAGE:'+user.profileImage!);
       await _storage.deleteFile(user.profileImage!);
      }
      await _storage.uploadFile(image, 'images/users/')
          .then((value) {
            userModel = UserModel(user.email, user.userName, user.phone, user.role, value!.url);
          } )
          .catchError((e){
            _hMessage.logMessageWithToast('Error : The profile not updated', true);
            _hDialog.hide(context);
          });

    }else{
      userModel = user;
    }
        _firestore.collection('Users').doc(userId).update(userModel!.toMap())
          .then((value) {
        _hDialog.hide(context);
        _hMessage.logMessageWithToast('Profile update successfully', true);
        Provider.of<MainProvider>(context,listen: false).refreshUserData(userModel!);
        //SharedPreferencesHelper().saveUserData(user);
      })
          .catchError((e){
        _hMessage.logMessageWithToast(e.toString(), true);
        _hDialog.hide(context);
      });


   }


  addCategory(String categoryName,File image) async{
      dynamic imageData;

      _hDialog.show(context, 'Adding Category ...');

    //upload image
    await _storage.uploadFile(image, 'images/categories/')
        .then((value) =>{imageData=value} )
        .catchError((e){
      _hMessage.logMessageWithToast('Error : The category not added', true);
      _hDialog.hide(context);
    });

    if(imageData != null){
      imageData = imageData as FirebaseStorageModel;
      var data = CategoryModel(TransNameModel('',categoryName), imageData, Timestamp.now());
      await _firestore.collection('Categories').add(data.toMap())
          .then((value) {
        Provider.of<MainProvider>(context,listen: false).getCategories(context);
        _hMessage.logMessageWithToast('The category added successfully', true);
        _hDialog.hide(context);
        Navigator.pop(context);
      })
          .catchError((e) {
        _hDialog.hide(context);
      });
    }else{
      _hMessage.logMessageWithToast('Error : The category not added', true);
      _hDialog.hide(context);
    }

  }


  addRecipe(String title,Map<String,String> category,String description,File image) async{

    dynamic imageData;
    _hDialog.show(context, 'Adding Recipe ...');

    //upload image
    await _storage.uploadFile(image, 'images/recipes/')
        .then((value) =>{imageData=value} )
        .catchError((e){
      _hMessage.logMessageWithToast('Error : The recipe not added', true);
      _hDialog.hide(context);
    });

    if(imageData != null){
      imageData = imageData as FirebaseStorageModel;
      final uuid= const Uuid().v1();
      final recipeModel = RecipeModel(uuid,_auth.currentUser!.uid, title, description, category, imageData, Timestamp.now());
      await _firestore.collection('Recipes').doc(uuid).set(recipeModel.toMap())
          .then((value) => {
        _hMessage.logMessageWithToast('The recipe added successfully', true),
        _hDialog.hide(context),
        Provider.of<MainProvider>(context,listen: false).refreshHome(recipeModel),
        Navigator.pop(context)
      })
          .catchError((e) {
            _hMessage.errorMessage(e);
        _hDialog.hide(context);
      });

    }else{
      _hMessage.logMessageWithToast('Error : The recipe not added', true);
      _hDialog.hide(context);
    }

  }


  updateRecipe(String recipeId,String title,Map<String,String> category,String description,FirebaseStorageModel sImage,File? image) async{
    dynamic imageData;
    Map<String,dynamic> data;
    RecipeModel recipeModel;

    _hDialog.show(context, 'Update Recipe ...');

    //upload image
    if(image!=null){
      await _storage.deleteFile(sImage.url);
      await _storage.uploadFile(image, 'images/recipes/')
          .then((value) =>{imageData=value} )
          .catchError((e){
        _hMessage.logMessageWithToast('Error : The recipe not added', true);
        _hDialog.hide(context);
      });
      imageData = imageData as FirebaseStorageModel;
      recipeModel = RecipeModel(recipeId,_auth.currentUser!.uid, title, description, category, imageData, Timestamp.now());
      data = recipeModel.toMap();
    }else{
      recipeModel = RecipeModel(recipeId,_auth.currentUser!.uid, title, description, category, sImage, Timestamp.now());
      data = recipeModel.toMap();
    }

      await _firestore.collection('Recipes').doc(recipeId).update(data)
          .then((value) => {
        _hMessage.logMessageWithToast('The recipe updated successfully', true),
        Provider.of<MainProvider>(context, listen: false).refreshMyRecipeList(recipeModel),
         _hDialog.hide(context),
         Navigator.pop(context)

        // _hDialog.hide(context),
        //Navigator.pop(context)
      })
          .catchError((e) {
        _hMessage.errorMessage(e,logName: 'FirestoreRepository:updateRecipe()');
        _hDialog.hide(context);
      });
    }


  removeRecipe(String recipeId) async{
    _hDialog.show(context, 'Delete ....');
    await _firestore.collection('Recipes').doc(recipeId).delete()
        .then((value) =>{
      _hDialog.hide(context),
      _hMessage.logMessageWithToast('The recipe is delete successfully', true),
    }).catchError((e){
      _hDialog.hide(context);
      _hMessage.logMessageWithToast(e.toString(), true);
    });
  }

 //Get all Categories
  Future<List<CategoryModel>?>getCategories()async{
    try{
      final category = await _firestore.collection('Categories').get();
      if(category.docs.isNotEmpty){
        log('getCategories');
        return category.docs.map((e) => CategoryModel.fromMap(e.id,e.data())).toList();
      }
    }catch(e){
      _hMessage.logMessageWithToast(e.toString(), true);
    }
    return [];
  }


  //Get All Recipes or Get Recipes by Category
  Future<List<RecipeModel>?>getRecipes({String?userId,String? categoryId,List<String>? idsList})async{
    List<RecipeModel> list;
    QuerySnapshot<Map<String,dynamic>> data;
    try{
      if(userId != null){ //get recipe by userId
        data = await _firestore.collection('Recipes').where('userId',isEqualTo: userId).get();

      }else if(categoryId !=null){ //get recipe by categoryId
        data = await _firestore.collection('Recipes').where('category.id',isEqualTo: categoryId).get();

      }else{ //get all recipe
        data = await _firestore.collection('Recipes').get();
      }

      if(data.docs.isNotEmpty){
        list =data.docs.map((e) => RecipeModel.fromMap(e.data())).toList();
        return list;
      }
    }catch(e){
      _hMessage.logMessageWithToast(e.toString(), true,logName: 'FirestoreRepository:getRecipes()');
    }
    return [];
  }


  //get favorite
  Future<List<FavoriteSModel>?>getFavorite() async{
    List<FavoriteModel>? favoriteIds;
  try{
     final data = await _firestore.collection('Favorite').where('userId',isEqualTo:userId).get();

     if(data.docs.isNotEmpty){
       favoriteIds = data.docs.map((e) => FavoriteModel.fromMap(e.id, e.data())).toList();
       final list = await getFavoriteList(favoriteIds);
       if(list!=null){
           log('Favorite Items'+list.toString());
           return list;
       }
     }
   }catch(e){
     _hMessage.logMessageWithToast(e.toString(), true,logName: 'FirestoreRepository:getFavorite()');
   }
    return [];
  }


  //Get Recipes/FavoriteList from favoriteIdsList
  Future<List<FavoriteSModel>?>getFavoriteList(List<FavoriteModel> favoriteIds) async{
    List<FavoriteSModel>? list=[];
 try{
   final recipeIds = favoriteIds.map((e) => e.recipeId).toList();
   final docsIds = favoriteIds.map((e) => e.id).toList();
    final data = await _firestore.collection('Recipes').where('id',whereIn: recipeIds).get();
    if(data.docs.isNotEmpty){ //to check if recipes is not deleted
      final recipeList= data.docs.map((e) => RecipeModel.fromMap( e.data())).toList();
      for (var i = 0; i < favoriteIds.length; i++) {
        list.add(FavoriteSModel.fromMap(docsIds[i].toString(), recipeList[i]));
      }
      return list;
    }

 }catch(e){
     _hMessage.logMessageWithToast(e.toString(), false,logName: 'FirestoreRepository:getFavoriteList()');
   }
    return null;
  }


  //add to favorite
  addToFavorite(String recipeId)async{
    //check in favorite
    final data = await _firestore.collection('Favorite').where('recipeId',isEqualTo: recipeId).where('userId',isEqualTo: userId).get();
    //if recipe in favorite [DELETE FROM FAVORITE]
    if(data.docs.isNotEmpty ){
      //convert favorite data to list to get docId for current recipe
      final dataList = data.docs.map((e) => FavoriteModel.fromMap(e.id, e.data())).toList();
      //docId
      final docId=dataList.firstWhere((element) => element.recipeId==recipeId).id;
      //remove
      await removeFromFavorite(docId!);
      //remove this doc/recipe from favoriteList
      Provider.of<MainProvider>(context, listen: false).homeRemoveFromFavorite(recipeId);
    } else{
      // [ADD TO FAVORITE]
      await _firestore.collection('Favorite').add(FavoriteModel(userId, recipeId).toMap())
          .then((value) =>{
          //add recipe in favoriteList from homeList
          Provider.of<MainProvider>(context, listen: false).homeAddToFavorite(recipeId),
         _hMessage.logMessageWithToast('Recipe added to favorite ♡', true)})
          .catchError((e){
        _hMessage.logMessageWithToast(e.toString(), true);
      });

    }
  }


  //delete from favorite using DocId
  removeFromFavorite(String docId)async{
    await _firestore.collection('Favorite').doc(docId).delete()
        .then((value) =>
        _hMessage.logMessageWithToast('The recipe is removed 🗑', true)
          )
        .catchError((e){
          _hMessage.logMessageWithToast(e.toString(), true,logName: 'FirestoreRepository:removeFromFavorite()');
        });
  }





}