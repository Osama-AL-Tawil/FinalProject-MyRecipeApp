import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:recipes_project/helpers/toast_message.dart';

class ValidationHelper{

  bool emailValidator(String value) {
    if (value.isEmpty) {
      toastMessage(" Email address is required");
      return false;
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      toastMessage("Please enter a valid email address");
      return false;
    }
    return true;
  }

  bool textValidator(String value, String fieldName){
    if (value.isEmpty) {
      toastMessage("$fieldName is required");
      return false;
    }
    return true;
  }

  bool passwordValidator(String value){
   // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
   //  r'^
   //    (?=.*[A-Z])       // should contain at least one upper case
   //    (?=.*[a-z])       // should contain at least one lower case
   //    (?=.*?[0-9])      // should contain at least one digit
   //    (?=.*?[!@#\$&*~]) // should contain at least one Special character
   //      .{8,}           // Must be at least 8 characters in length
   //  $

    if (value.isEmpty) {
      toastMessage("The password is required");
      return false;
    }
    if(value.length<9){
      toastMessage("The password must have at least 9 characters");
      return false;
    }
    return true;
  }

  bool passwordMatchingValidator(String password,String passwordConfirmation){
    if(password==passwordConfirmation){
      return true;
    }else{
      toastMessage("The password not matching");
      return false;
    }
  }

  bool phoneValidator(String value){
    if (value.isEmpty) {
      toastMessage("The MobileNumber is required");
      return false;
    }
     if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
       toastMessage("Please enter valid mobile number");
       return false;
    }
    return true;
  }

  bool fileValidator(File? file,String fileType){
    if (file==null) {
      toastMessage("The $fileType is required");
      return false;
    }else{
      return true;
    }
  }

  bool isArabic(BuildContext context,String value) {
    var locale = Localizations.localeOf(context);
    if (RegExp(r"(^[\u0621-\u064A0-9]|[\u0621-\u064A\u0660-\u0669]+$)")
        .hasMatch(value)) {
      //toastMessage(locale.languageCode);
      log('ar');
      return true;
    }
    //toastMessage(locale.languageCode);
    //toastMessage("English");
    log('en');

    return false;
  }

}
