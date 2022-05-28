
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/firebase/storage_repository.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/models/trans_name_model.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/helpers/image_picker_helper.dart';
import 'package:recipes_project/helpers/toast_message.dart';
import 'package:recipes_project/models/category_model.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';

class AddRecipe extends StatefulWidget {
  bool? editMode;
  RecipeModel? data;
  AddRecipe({Key? key,this.editMode=false,this.data}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  // String? recipeName;
  // String? description;
  List<CategoryModel>? categories ;
  File? image;
  Map<String,String>? selectedCategory;
 // Map<String,CategoryModel>? selectedItem;
  bool isLoading=false;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
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
  imageWidget(){
    if(image!=null){
      final img = Image.file(image!,fit:BoxFit.cover ,height: 150,width: 150,);
      return [ClipRRect(borderRadius:BorderRadius.circular(14),child: img,),const Icon(Icons.close, color: primaryColor,size: 50,)];
    }
    else if(widget.editMode==true){
      if(widget.data!.image.url!=''){
        final img=FadeInImage.assetNetwork(placeholder: 'assets/d_placeholder.png', image: widget.data!.image.url,fit:BoxFit.cover ,height: 150,width: 150);
        return [ClipRRect(borderRadius:BorderRadius.circular(14),child: img,),const Icon(Icons.close, color: primaryColor,size: 50,)];
      }
    }
    return [const Icon(Icons.add, color: primaryColor,size: 50,)];
  }


  @override
  Widget build(BuildContext context) {
    double borderRadius = 14;
    categories = Provider.of<MainProvider>(context,listen: true).categories;
    if(categories==null){
      Provider.of<MainProvider>(context,listen: false).getCategories(context);
    }
    if(widget.editMode==true && title.text==''){
      title.text=widget.data!.title;
      description.text=widget.data!.description;
      selectedCategory={'id':widget.data!.category['id'].toString(),'name':widget.data!.category['name'].toString()};
    }

    return Scaffold(
      appBar: AppBar(title:  Text(widget.editMode==true?"Edit Recipe":"Add Recipe"),backgroundColor: primaryColor,),
      body: categories!=null? SingleChildScrollView(child: Column(
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
                  child:Stack(alignment: Alignment.center,
                    children: imageWidget()
                  ),

                ),)

          ),
          SizedBox(height: 3.h,),
          TextFieldWidget(
              hintText: 'Recipe Name',
              marginBottom: 20,
              controller: title,
              onChanged: (value) => {}),
          SizedBox(
            width: MediaQuery.of(context).size.width-30,
            child:DropdownButtonFormField2(
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),

              ),
              isExpanded: true,
              hint: const Text(
                'Select Recipe Category',
                style: TextStyle(fontSize: 15),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              value: widget.editMode==true&&widget.data!=null?widget.data!.category['id']:null,
              items: categories!.map((item) =>
                  DropdownMenuItem(
                    value: item.id,
                    child: Text(item.name.en.toString(),
                      style: const TextStyle(fontSize: 14),),
                  )).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select Category';
                }
              },
              onChanged: (value) {
                //var data= value as CategoryModel;
                var data= categories!.firstWhere((element) => element.id==value);
                selectedCategory={'id':data.id!,'name':data.name.en.toString()};
               //log(data.name.toString());
                //Do something when changing the item if you want.
              },

            ),),
          SizedBox(height: 2.h,),
          TextFieldWidget(
            hintText: 'Description',
            controller: description,
            onChanged: (value) => {log('ONC:'+value)},marginBottom: 10,maxLines: 6,),
          SizedBox(height: 1.h,),
          ButtonWidget(label: widget.editMode==true?"Update":"Create", press:(){
            if(title.text!=''&& description.text!=''&& selectedCategory!=null){
              if(widget.editMode==false && image!=null){
                FirestoreRepository(context).addRecipe(title.text,selectedCategory!,description.text, image!);
              }else{//editMode
                FirestoreRepository(context).updateRecipe(widget.data!.id,title.text,selectedCategory!,description.text,widget.data!.image,image);
              }
            }else{
              toastMessage('Please fill all fields and Choose Recipe Image');
            }
          }, textColor: whiteColor, backgroundColor: primaryColor)
              ],
      ))
           :Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)

    );
  }
}
