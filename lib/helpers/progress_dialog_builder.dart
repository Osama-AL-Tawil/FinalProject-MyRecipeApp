import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogBuilder{
  final BuildContext context;
  CustomAlertDialogBuilder(this.context);
  static const double alertBorderRadius = 8.0;


  void createAlertDialog(
      Widget content,
      double verticalPadding,
      double horizontalPadding,
      {
        double borderRadius = alertBorderRadius,
        Color backgroundColor = const Color(0xFFECECEC),
        isDismissible = true

      }) {
    showDialog(context: context,barrierDismissible: isDismissible, builder: (BuildContext context){
      return WillPopScope(
          onWillPop: () async => false,
          child:  AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            backgroundColor: backgroundColor, //Background Color
            content:content ,
          )
      );
    });
  }



}

class HorizontalProgressAlertDialog {
  BuildContext context;
  double horizontalPadding;
  double verticalPadding;
  Row? moreContent;

  HorizontalProgressAlertDialog(this.context,{this.horizontalPadding = 50, this.verticalPadding = 100,this.moreContent});

  void show(BuildContext context,String message) {
    CustomAlertDialogBuilder(context).createAlertDialog(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const LoadingIndicatorWidget(),
          const SizedBox(width: 20,),
          DialogTextWidget(text: message),
          moreContent!=null?moreContent!:const SizedBox(height: 0,width: 0,)//column to add more widgets

        ],), verticalPadding, horizontalPadding);
  }

  void hide(BuildContext context,) {
    Navigator.pop(context);


  }
}

class VerticalProgressAlertDialog {
  BuildContext context;
  double horizontalPadding;
  double verticalPadding;
  Column? moreContent;

  VerticalProgressAlertDialog(this.context, {this.horizontalPadding = 120, this.verticalPadding = 120,this.moreContent});

  void show(String message){
    CustomAlertDialogBuilder(context).createAlertDialog(
     Container(
       padding: EdgeInsets.all(3),
       child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            const LoadingIndicatorWidget(),
            const SizedBox(height: 15),
            DialogTextWidget(text: message),
              moreContent!=null?moreContent!:const SizedBox()//column to add more widgets
          ],),
        )
        ,verticalPadding , horizontalPadding);
  }

  void hide() {
    Navigator.of(context).pop();
  }

}



class LoadingIndicatorWidget extends StatelessWidget{
  final double indicatorSize ;
  final double strokeWidth;
  const LoadingIndicatorWidget({Key? key,this.indicatorSize=32,this.strokeWidth=3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: const CircularProgressIndicator(strokeWidth: 3),
      width: indicatorSize,
      height: indicatorSize,
      //margin: const EdgeInsets.only(bottom: 15),
    );
  }

}


class DialogTextWidget extends StatelessWidget{
  final String text ;
  final Color textColor;
  final TextAlign textAlign;
  const DialogTextWidget({Key? key,required this.text,this.textColor= Colors.black,this.textAlign=TextAlign.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style:  TextStyle(
          color:textColor,
          fontSize: 14
      ),
      textAlign: textAlign,
    );
  }

}