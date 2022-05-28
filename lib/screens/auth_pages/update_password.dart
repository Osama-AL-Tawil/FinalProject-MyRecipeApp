import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/firebase/auth_repository.dart';
import 'package:recipes_project/helpers/toast_message.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/colors.dart';
import 'package:recipes_project/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';

class UpdatePasswordPage extends StatelessWidget {
  UpdatePasswordPage({Key? key}) : super(key: key);
  TextEditingController password =TextEditingController();
  TextEditingController passwordConfirmation =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Password'),backgroundColor: primaryColor,),
      body: Column(crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Text('Update Your Password',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20.sp,color: Colors.black),),
          const SizedBox(height: 40,),
          TextFieldWidget(hintText: 'Password', controller:password),
          const SizedBox(height: 10,),
          TextFieldWidget(hintText: 'PasswordConfirmation', controller: passwordConfirmation,),
          const SizedBox(height: 15,),
          ButtonWidget(label:'Change Password', press:(){updatePassword(context);})
        ],),
    );
  }

  updatePassword(BuildContext context) {
    if (ValidationHelper().passwordValidator(password.text)&&
        ValidationHelper().passwordValidator(passwordConfirmation.text)&&
        ValidationHelper().passwordMatchingValidator(password.text, passwordConfirmation.text)
    ) {

      AuthRepository(context).updatePassword(password.text);
    }
  }

}
