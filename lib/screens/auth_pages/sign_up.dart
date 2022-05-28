import 'package:flutter/material.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:recipes_project/screens/auth_pages/sign_in.dart';
import 'package:recipes_project/widgets/ButtonText.dart';
import 'package:recipes_project/widgets/auth/background.dart';
import 'package:recipes_project/widgets/auth/title.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/password_field.dart';
import 'package:recipes_project/widgets/text_field.dart';
import '../../app_constants.dart';
import '../../firebase/auth_repository.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignupState();
}

class _SignupState extends State<SignUpPage> {
  String email ="";
  String name="";
  String phone="";
  String password="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          children: [
            const AuthBackground(),
            Column(
              children: [
                const AuthTitle(title: 'SIGN UP'),
                const SizedBox(height: 20,),
                TextFieldWidget(hintText: 'FullName', onChanged: (value) {name=value;}),
                TextFieldWidget(hintText: 'Email', onChanged: (value) {email=value;}),
                TextFieldWidget(hintText: 'Phone', onChanged: (value) {phone=value;}),
                PasswordFieldWidget(hintText: 'Password', onChanged: (value) {password=value;}),
                ButtonWidget(label: 'SignUp',textColor: whiteColor,backgroundColor: primaryColor,
                    press: (){signup();}),
                const SizedBox(height: 10),
                ButtonTextWidget(text: 'Do you have account? SignIn', press: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
                })
              ],
            ),
          ],
        ),
      ),
    );

  }

  signup(){
    ValidationHelper _vHelper =ValidationHelper();
    if (_vHelper.emailValidator(email) &&
        _vHelper.passwordValidator(password) &&
        _vHelper.textValidator(name, 'UserName') &&
        _vHelper.phoneValidator(phone)
    ) {
      UserModel user = UserModel(email, name, phone, 'user', null);
      AuthRepository(context).signup(user,password);
    }
  }


}
