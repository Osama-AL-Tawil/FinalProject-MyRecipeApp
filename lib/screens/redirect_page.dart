import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/main.dart';
import 'package:recipes_project/screens/welcome_info.dart';

import '../helpers/shared_preferences.dart';
import 'main_pages/my_home_page.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({Key? key}) : super(key: key);

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  Widget build(BuildContext context) {
    redirectPage();
    return Scaffold(body:Container());
  }

    redirectPage()async{
      FirebaseAuth auth  =FirebaseAuth.instance;
      final isAuth = await SharedPreferencesHelper().checkIfGuest();
    if(auth.currentUser!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MyHomePage()));
    }else if(auth.currentUser==null&& isAuth==true){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MyHomePage()));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const WelcomePage()));
    }
  }

}

