import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_project/firebase/auth_repository.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/screens/auth_pages/forget_password.dart';
import 'package:recipes_project/screens/auth_pages/sign_up.dart';
import 'package:recipes_project/widgets/ButtonText.dart';
import 'package:recipes_project/widgets/auth/background.dart';
import 'package:recipes_project/widgets/auth/title.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/password_field.dart';
import 'package:recipes_project/widgets/text_field.dart';

import '../../app_constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState()=>_SignInState();
}
class _SignInState extends State<SignInPage>{
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          const AuthBackground(),
         Column(
              children: [
                const AuthTitle(title: 'SIGN IN'),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(hintText: 'Email', onChanged: (value){email=value;}),
                PasswordFieldWidget(hintText: 'Password', onChanged: (value){password=value;}),
                ButtonWidget(label: 'SignIn',textColor: whiteColor,backgroundColor: primaryColor, press: (){
                 signIn();
                }),
                const SizedBox(height: 20,),
                TextButton(onPressed: () =>{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPasswordPage()))
                } , child: const Text('Forget Password ?')),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Connect With',style: TextStyle(fontSize: 14,fontWeight:FontWeight.normal,color: primaryColor),),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: SvgPicture.asset('assets/ic_facebook.svg')),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: SvgPicture.asset('assets/ic_twitter.svg'))
                  ],
                ),
                ButtonTextWidget(text: 'Do not have an account? Sign up', press: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpPage()));
                }),

              ],
            ),
        ],
      ),),
    );
  }

  signIn(){
    final vHelper = ValidationHelper();
    if (vHelper.emailValidator(email) &&
        vHelper.passwordValidator(password)) {
      AuthRepository(context).login(email, password);
    }
  }

}

