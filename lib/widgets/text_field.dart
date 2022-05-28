import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/helpers/validation_helper.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final double? radius;
  final double? marginBottom;
  final int? height;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const TextFieldWidget({Key? key,
    required this.hintText,
    this.onChanged,
    this.marginBottom = 20,
    this.radius = 30,
    this.height,
    this.controller,
    this.maxLines = 1})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextDirection? direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, widget.marginBottom!),
      child: TextField(
        //textAlign: direction==null?TextAlign.start:direction!,
        textDirection:direction==null?TextDirection.ltr:direction!,
        // style: TextStyle(fontSize: 14,fontStyle: FontStyle.italic),
        decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius!))),
        onChanged:(value){
          textDecoration(context, value);
          widget.onChanged!.call(value);
        },
        maxLines: widget.maxLines,
        controller: widget.controller,
      ),);
  }

  textDecoration(BuildContext context, String text) {
    if (ValidationHelper().isArabic(context, text)) {
      setState(()=> {
        direction= TextDirection.rtl
      });
      //log(direction.toString());
    }else{
      setState(()=> {
        direction= TextDirection.ltr
      });
      //log(direction.toString());

    }

  }
}

