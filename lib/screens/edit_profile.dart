import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/helpers/shared_preferences.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:recipes_project/screens/auth_pages/update_password.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/outline_button_widget.dart';
import 'package:recipes_project/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';
import '../providers/main_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel? user;
  File? imageFile;
  String profileImage=profilePlaceholder;

  TextEditingController  email = TextEditingController();
  TextEditingController  name = TextEditingController();
  TextEditingController  phone = TextEditingController();

  removeImage() {
    setState(() => {imageFile = null});
    Fluttertoast.showToast(msg: 'Image removed Successfully',backgroundColor: grayColor);
  }

  getDataFromSharePref()async{
    if(user==null){
      user = Provider.of<MainProvider>(context,listen: true).user;
      //user = await SharedPreferencesHelper().getUserData();
      if(user!=null){
        email.text=user!.email.toString() ;
        name.text=user!.userName.toString() ;
        phone.text=user!.phone.toString() ;
        if(user!.profileImage !=null && user!.profileImage!=''){
          profileImage = user!.profileImage!.toString();
        }
        setState(() {

        });
      }
    }

  }

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)return;
      final imageTemporary = File(image.path);
      setState(()=>{imageFile =imageTemporary});
    }on PlatformException catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }

  Widget imageWidget(){
    if(imageFile!=null){
      return Image.file(imageFile!,height: 150,width: 150,fit: BoxFit.cover,);
    }else if(user!.profileImage!=null && user!.profileImage!=''){
      return Image.network(user!.profileImage!,height: 150,width: 150,fit: BoxFit.cover,);
    }else{
      return Image.asset(profileImage,height: 150,width: 150,fit: BoxFit.cover,);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataFromSharePref();
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),backgroundColor: primaryColor,),
      body: SingleChildScrollView(child: user!=null? Column(
        children: [
          SizedBox(height: 3.h,),
          InkWell(
            hoverColor: Colors.black,
            onTap:(){
              if(imageFile!=null){
                removeImage();
              }else{
                pickImage();
              }},child:
          ClipOval(child:
          Stack(alignment:Alignment.center,children: [
            imageWidget(),
            imageFile!=null?const Icon(Icons.close, color: Colors.white,size: 50,):
            const Icon(Icons.add, color: Colors.white,size: 50,),
          ],)
          )
            ,),


           SizedBox(height: 3.h,),
          TextFieldWidget(
              hintText: 'UserName',
              marginBottom: 15,
              controller: name,
              onChanged: (value) => {}),
          TextFieldWidget(
            hintText: 'Email',
            controller: email,
            onChanged: (value) => {},marginBottom: 15,),
          TextFieldWidget(
            hintText: 'PhoneNumber',
            controller: phone,
            onChanged: (value) => {},marginBottom: 10,),
          SizedBox(height: 1.h,),
          OutlineButtonWidget(label: 'Edit Password', backgroundColor: whiteColor, borderColor: primaryColor, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePasswordPage()));
          }),
          SizedBox(height: 2.h,),
          ButtonWidget(label: "SAVE", press: (){ updateProfile();
          }, textColor: whiteColor, backgroundColor: primaryColor)
        ],
      ):const SizedBox(),),
    );
  }


  updateProfile(){
    if(ValidationHelper().emailValidator(email.text)&&
        ValidationHelper().textValidator(name.text,'Name')&&
        ValidationHelper().phoneValidator(phone.text)
    ){
      final data = UserModel(email.text, name.text, phone.text, user!.role, user!.profileImage);
      FirestoreRepository(context).updateUserData(data, imageFile);
    }
  }


}
