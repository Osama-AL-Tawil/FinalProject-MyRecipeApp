import 'package:flutter/cupertino.dart';

class TextCWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;

  const TextCWidget({Key? key, required this.text, this.style,this.maxLines})
      : super(key: key);
  final String arabicFont = 'Cairo';
  final String englishFont = '';

  @override
  Widget build(BuildContext context) {
    return textWidget(context,text);
  }

   textWidget(BuildContext context,String text) {
    final local = Localizations.localeOf(context).languageCode;

    //arabic regex
    if (RegExp(r"(^[\u0621-\u064A0-9]|[\u0621-\u064A\u0660-\u0669]+$)").hasMatch(text)) {
       //if the text is Arabic and App local is Arabic text start from right
        return Padding(padding: const EdgeInsets.only(right: 5 ,left: 1.5)
          ,child:Text(text, style:style,textAlign: TextAlign.right,maxLines: maxLines,) ) ;

    }else{
     //if the text is English and App local is English or another
     return Padding(padding: const EdgeInsets.only(left: 5,right: 1.5)
     ,child:Text(text, style:style,textAlign: TextAlign.left,maxLines: maxLines,) ,) ;
    }
  }


}
