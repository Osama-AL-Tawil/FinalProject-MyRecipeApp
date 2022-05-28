import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipes_project/widgets/colors.dart';

toastMessage(String message,{Color backgroundColor=const Color(0xF8767676)}){

  Fluttertoast.showToast(msg: message.toString(),textColor:Colors.white,backgroundColor: backgroundColor );
}