import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipes_project/models/image_model.dart';

import '../helpers/handle_message_helper.dart';
import '../helpers/progress_dialog_builder.dart';

class StorageRepository {
  BuildContext context;
  StorageRepository(this.context);

  final storage = FirebaseStorage.instance;
  final HandleMassageHelper _hMessage = HandleMassageHelper();
  late final HorizontalProgressAlertDialog _hDialog  =HorizontalProgressAlertDialog(context);
  final _logName= 'OS:FirebaseStorage';

  Future<void> deleteFile(String fileUrl)async{
    return await storage.refFromURL(fileUrl).delete();
  }

  Future<FirebaseStorageModel?>uploadFile(File file, String path) async{
    var randomId = DateTime.now().microsecondsSinceEpoch.toString();
    var filePath = path + randomId;
    FirebaseStorageModel? storageModel;
    TaskSnapshot? taskSnapshot;
    String? url;
    await storage.ref().child(filePath).putFile(file)
        .then((p0) => {taskSnapshot=p0})
        .catchError((e) {_hMessage.errorMessage(e,logName: _logName) ;
    });

    if(taskSnapshot != null){
      var imagePath = taskSnapshot!.ref.fullPath.toString();

      await taskSnapshot!.ref.getDownloadURL().then((value) => { url =value})
      .catchError((e){_hMessage.errorMessage(e,logName: _logName);});

      if(url != null){
        storageModel=FirebaseStorageModel(url.toString(),imagePath);
        _hMessage.logMessageWithToast('The file uploaded successfully', true);
         log('IMAGE_URL'+url.toString());
      }else{
        _hMessage.logMessageWithToast('Failed to upload file', true);
      }

    }
    return storageModel;

  }
}

class FirebaseStorageModel{
  String url;
  String? path;
  FirebaseStorageModel(this.url,this.path);
  toMap(){
    return {'url':url, 'path':path};
  }
  FirebaseStorageModel.fromMap(Map<String,dynamic>map)
      :url=map['url'],
      path=map['path'];
}