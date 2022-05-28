import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_project/firebase/storage_repository.dart';
import 'package:recipes_project/models/trans_name_model.dart';

class CategoryModel{
  TransNameModel name;
  Timestamp timestamp;
  FirebaseStorageModel imageData;
  String? id;
  CategoryModel(this.name,this.imageData,this.timestamp);

  CategoryModel.fromMap(String docId ,Map<String, dynamic> map)
        :name = TransNameModel(map['name']['ar'], map['name']['en']),
        timestamp=map['timestamp'],
        imageData=FirebaseStorageModel(map['imageData']['url'], map['imageData']['path']),
        id=docId
  ;

  toMap(){
    return {'name':name.toMap(),'timestamp':timestamp,'imageData':imageData.toMap()};
  }
}