import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/helpers/image_picker_helper.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var categoryName = '';
  String? selectedItem = 'c1';
  File? image;

  imageOnTap(){
    if(image!=null){
      setState(() => {image = null});
      Fluttertoast.showToast(msg: 'Image removed Successfully',backgroundColor: grayColor);
    }else{
      ImagePickerHelper().pickImage().then((value) =>
          setState(()=>{ image= value })
      );
    }
  }

  addCategory(){
    if(ValidationHelper().fileValidator(image, 'Image') &&
        ValidationHelper().textValidator(categoryName, 'CategoryName'))
    {
      FirestoreRepository(context).addCategory(categoryName, image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double borderRadius = 14;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Category'),backgroundColor: primaryColor,),
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(height: 3.h,),
          SizedBox(width: 150, height: 150,
              child:Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
                elevation: 3,
                child:InkWell(
                  hoverColor: Colors.black,
                  onTap:(){imageOnTap();},
                  child: Stack(alignment: Alignment.center,
                    children: [
                      image!=null? ClipRRect(borderRadius:BorderRadius.circular(borderRadius),child: Image.file(image!,fit:BoxFit.fill ,height: 150,width: 150,),):const SizedBox(),
                      image!=null?const Icon(Icons.close, color: primaryColor,size: 50,):
                      const Icon(Icons.add, color: grayColor,size: 50,)
                      ,
                    ],
                  ),

                ),)

          ),
          SizedBox(height: 3.h,),
          TextFieldWidget(
              hintText: 'Category Name',
              marginBottom: 20,
              onChanged: (value) => {categoryName = value}),
          SizedBox(height: 2.h,),
          ButtonWidget(label: "Add Category", press:(){addCategory();},
              textColor: whiteColor, backgroundColor: primaryColor)
        ],
      ),),
    );
  }
}
