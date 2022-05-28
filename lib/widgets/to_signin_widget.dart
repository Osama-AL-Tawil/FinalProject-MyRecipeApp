import 'package:flutter/material.dart';

import '../screens/auth_pages/sign_in.dart';

class ToSignInWidget extends StatelessWidget {
  final String message;
  final String? buttonTitle;
  const ToSignInWidget({Key? key,required this.message, this.buttonTitle='SignIn'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
           Text(message,textAlign: TextAlign.center,),
          const SizedBox(height: 20,),
          OutlinedButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignInPage()));
          }, child: Text(buttonTitle!))
        ],),);
  }
}
