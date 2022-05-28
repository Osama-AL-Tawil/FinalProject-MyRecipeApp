import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app_constants.dart';
import '../../helpers/image_picker_helper.dart';

class SingleImagePickerView extends StatefulWidget {
  bool? isEditMode;
  File? imageFile;
  String? imageUrl;
  String? placeholderImage;
  double? height;
  double? width;
  double? circleSize;
  double? layoutBorderRadius;
  double? elevation;
  String layoutType;
  Function? onImageClick;
  SingleImagePickerView({Key? key,
    required this.imageFile,
    required this.layoutType,
    this.isEditMode = false,
    this.imageUrl,
    this.placeholderImage='assets/d_placeholder.png',
    this.onImageClick,
    this.height=150,
    this.width=150,
    this.circleSize=70,
    this.layoutBorderRadius=14,
    this.elevation = 3,

  }) : super(key: key);


  @override
  State<SingleImagePickerView> createState() => _SingleImagePickerViewState();

}

class _SingleImagePickerViewState extends State<SingleImagePickerView> {
 final closeIcon =const Icon(Icons.close, color: primaryColor,size: 50,);
 final addIcon = const Icon(Icons.add, color:Color(0xFFFA4B4B),size: 50,);


  imageOnTap(){
    if(widget.imageFile!=null){
      setState(() => {widget.imageFile = null});
      Fluttertoast.showToast(msg: 'Image removed Successfully',backgroundColor: const Color(0xFFACACAC));
    }else{
      ImagePickerHelper().pickImage().then((value) =>
          setState(()=>{ widget.imageFile = value })
      );
    }
  }

  roundedImageWidget(){
    if(widget.imageFile!=null){
      final img = Image.file(widget.imageFile!,fit:BoxFit.cover ,height: widget.height,width: widget.width,);
      return [ClipRRect(borderRadius:BorderRadius.circular(widget.layoutBorderRadius!),child: img,),const Icon(Icons.close, color: primaryColor,size: 50,)];
    }
    else if(widget.isEditMode==true){
      if(widget.imageUrl!=''){
        final img=FadeInImage.assetNetwork(placeholder: widget.placeholderImage!, image: widget.imageUrl!,fit:BoxFit.cover ,height: 150,width: 150);
        return [ClipRRect(borderRadius:BorderRadius.circular(widget.layoutBorderRadius!),child: img,),const Icon(Icons.close, color: primaryColor,size: 50,)];
      }
    }
    return [const Icon(Icons.add, color:Color(0xFFFA4B4B),size: 50,)];
  }
  circleImageWidget(){
    if(widget.imageFile!=null){
      final img = FileImage(widget.imageFile!);
      return CircleAvatar(backgroundImage:img,radius: widget.circleSize,backgroundColor:const Color(0xFFDBDBDB) ,child:circleInkWillClick([closeIcon]));
    }
    else if(widget.isEditMode==true){
      if(widget.imageUrl!=''){
        final img = NetworkImage(widget.imageUrl!);
        return CircleAvatar(backgroundImage:img,radius: widget.circleSize,backgroundColor:const Color(0xFFDBDBDB),child:circleInkWillClick([closeIcon]));
      }
    }
    return CircleAvatar(radius: widget.circleSize,backgroundColor:const Color(0xFFDBDBDB),child:circleInkWillClick([addIcon]));
  }

  inkWillClick(List<Widget> listWidget){
    return InkWell(
      borderRadius: BorderRadius.circular(widget.layoutBorderRadius!),
      hoverColor: Colors.black,
      onTap: () {
        if (widget.onImageClick != null) {
          widget.onImageClick!();
        } else {
          imageOnTap();
        }
      },
      child:Stack(
          alignment: Alignment.center,
          children: listWidget
      ),

    );
  }
  circleInkWillClick(List<Widget> listWidget){
   return  Material(
       color: Colors.transparent,
       child: InkWell(
         borderRadius: BorderRadius.circular(widget.circleSize!),
         hoverColor: const Color(0x40000000),
         onTap: () {
           if (widget.onImageClick != null) {
             widget.onImageClick!();
           } else {
             imageOnTap();
           }
         },
         child: Stack(
             fit: StackFit.expand,
             alignment: Alignment.center,
             children: listWidget
         ),
       ));
 }


  buildLayout(){
    if(widget.layoutType ==LayoutType.circleLayout){
      return circleImageWidget();
    }else if(widget.layoutType ==LayoutType.roundedCardLayout){
      return SizedBox(width: widget.width, height: widget.height,
          child:Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.layoutBorderRadius!)),
            elevation: widget.elevation,
            child:inkWillClick(roundedImageWidget()),)

      ); //roundedCardLayout
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildLayout();
  }
}

class LayoutType{
  LayoutType._();
  static const roundedCardLayout= 'roundedCard';
  static const circleLayout= 'circle';
}

// ClipOval(
// child: Image.network(
// 'https://via.placeholder.com/150',
// width: 100,
// height: 100,
// fit: BoxFit.cover,
// ),
// ),