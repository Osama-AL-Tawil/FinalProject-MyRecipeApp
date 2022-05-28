import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/firebase/auth_repository.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';

class ForgetPasswordPage extends StatelessWidget {
   ForgetPasswordPage({Key? key}) : super(key: key);
  var email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password'),backgroundColor: primaryColor,),
      body: Column(crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Text('Reset Your Password',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20.sp,color: Colors.black),),
          const SizedBox(height: 10,),
          Text('The Reset link will send to your email ',style:TextStyle(fontSize: 9.sp,color: grayColor),),
          const SizedBox(height: 15,),
          TextFieldWidget(hintText: 'Email', onChanged: (value)=>{email=value}),
          const SizedBox(height: 15,),
          ButtonWidget(label:'Reset Password', press:(){forgetPassword(context);})
        ],),
    );
  }

  forgetPassword(BuildContext context){
    if (ValidationHelper().emailValidator(email)) {
      AuthRepository(context).forgetPassword(email);
    }
  }

}
