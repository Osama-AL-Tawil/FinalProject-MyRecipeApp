import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/main.dart';
import 'package:recipes_project/screens/main_pages/home_page.dart';
import 'package:recipes_project/screens/welcome_info.dart';

import '../helpers/shared_preferences.dart';
import 'main_pages/my_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 1);
    return Timer(_duration, () {
      //Navigate to another screen or anyOther function, like i set duration 4 sec so this function run after 4 sec
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage(title: '',)));
      redirectPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return SvgPicture.asset("assets/splash.svg",height: height,width: width,);
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