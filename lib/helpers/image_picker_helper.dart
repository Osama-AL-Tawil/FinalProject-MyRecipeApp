import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes_project/helpers/toast_message.dart';

class ImagePickerHelper{
  // File? fImage;
  //
  // removeImage(){
  //  fImage=null;
  //  notifyListeners();
  // }
  //
  // setImage(File imageTemporary){
  //   fImage = imageTemporary;
  //   notifyListeners();
  // }

  Future<File?> pickImage() async {
    File? fImage;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        toastMessage('You don' 't select image');
      } else {
        final imageTemporary = File(image.path);
        //setImage(imageTemporary);
        fImage = imageTemporary;
      }
    } on PlatformException catch (e) {
      toastMessage(e.toString());
    }
    return fImage ;

  }


  //Add In Class

  // File? image;
  // imageOnTap(){
  //   if(image!=null){
  //     setState(() => {image = null});
  //     Fluttertoast.showToast(msg: 'Image removed Successfully',backgroundColor: grayColor);
  //   }else{
  //     ImagePickerHelper().pickImage().then((value) =>
  //         setState(()=>{ image= value })
  //     );
  //   }
  // }


}