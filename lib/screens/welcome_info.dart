import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/helpers/shared_preferences.dart';
import 'package:recipes_project/main.dart';
import 'package:recipes_project/screens/auth_pages/sign_in.dart';
import 'package:recipes_project/screens/auth_pages/sign_up.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/outline_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../app_constants.dart';
import 'main_pages/my_home_page.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            SizedBox(height:4.h),
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.only(right: 5)
                ,child: TextButton(onPressed: (){
                  SharedPreferencesHelper().asGuest(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                  },
                      child: const Text('Skip>>',style: TextStyle(color: primaryColor),)),
                )

              ],),
            SizedBox(height:15.h),
            SvgPicture.asset('assets/v_1.svg'),
            SizedBox(height: 8.h,),
            Text('Welcome In My Recipe App',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18.sp),),
            SizedBox(height: 5.h,),
            const Text('Create an account or login to enjoy the services of the application and see the latest delicious recipes',textAlign:TextAlign.center,),

            SizedBox(height:30.h,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  ButtonWidget(label: 'SIGN UP', textColor: whiteColor,backgroundColor: primaryColor,press: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const SignUpPage()) );
                  }),
                  SizedBox(height: 1.h,),
                  OutlineButtonWidget(label: 'SIGN IN', backgroundColor: whiteColor, borderColor: primaryColor, onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                  }),
                  SizedBox(height:6.h,),

              ],),

            )

          ],
    ),),);
  }
}

