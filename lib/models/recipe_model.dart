import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_project/firebase/storage_repository.dart';

import 'image_model.dart';

class RecipeModel {
  String id;
  String userId;
  String title;
  String description;
  Map<String,String> category;
  FirebaseStorageModel image;
  Timestamp? timestamp;
  bool? inFavorite;
  RecipeModel(this.id,this.userId,this.title,this.description,this.category,this.image,this.timestamp,{this.inFavorite=false});

  RecipeModel.fromMap(Map<String, dynamic> map)
  :
      id=map['id'],
      inFavorite=false,
      userId=map['userId'],
      title=map['title'],
      description=map['description'],
      category={'id':map['category']['id'],'name':map['category']['name']},
      image=FirebaseStorageModel(map['image']['url'], map['image']['path']),
      timestamp=map['timestamp'];


  toMap(){
    return{'id':id,'userId':userId,'title':title,'description':description,
      'category':category,'image':image.toMap(),'timestamp':timestamp};
  }


}