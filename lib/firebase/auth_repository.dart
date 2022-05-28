import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/helpers/handle_message_helper.dart';
import 'package:recipes_project/helpers/shared_preferences.dart';
import 'package:recipes_project/helpers/toast_message.dart';
import 'package:recipes_project/helpers/validation_helper.dart';
import 'package:recipes_project/main.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/screens/auth_pages/sign_in.dart';
import 'package:recipes_project/screens/edit_profile.dart';
import 'package:recipes_project/screens/welcome_info.dart';
import 'package:recipes_project/helpers/progress_dialog_builder.dart';
import '../models/user_model.dart';
import '../screens/main_pages/my_home_page.dart';
import 'firestore_repository.dart';

class AuthRepository {
  BuildContext context;

  AuthRepository(this.context);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirestoreRepository _firestore = FirestoreRepository(context);
  late final HorizontalProgressAlertDialog _hDialog = HorizontalProgressAlertDialog(context);
  final HandleMassageHelper _hMessage = HandleMassageHelper();
  final String _logName = "OS:FirebaseAuth";


  bool checkUserIfAuth(){
    if(_auth.currentUser!=null){
      return true;
    }else{
      toastMessage('You must to signin to continue');
      return false;
    }
  }

  signup(UserModel user,String password) async {
    //show dialog
    try {
      _hDialog.show(context, 'Signup please wait ...');
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      if (credential.user != null) {
        await _firestore.setUserData(_auth.currentUser!.uid, user);
        SharedPreferencesHelper().asGuest(false);
        _hDialog.hide(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        _hDialog.hide(context);
        _hMessage.logMessageWithToast(
            'Wrong email or password', true, logName: _logName);
      }
    } catch (e) {
      _hDialog.hide(context);
      _hMessage.errorMessage(e, logName: _logName);
    }
  }



  void login(String email, String password) async {
     _hDialog.show(context, 'Login please wait ...');
     try{
       final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
       if(credential.user!=null){
         SharedPreferencesHelper().asGuest(false);
         _hDialog.hide(context);
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context) => const MyHomePage()));
       }else{
         _hDialog.hide(context);
         _hMessage.logMessageWithToast('Wrong email or password', true, logName: _logName);
       }
     }catch(e){
       _hDialog.hide(context);
       _hMessage.logMessageWithToast(e.toString(), true, logName: _logName);
     }

  }


    void forgetPassword(String email) async {
        _hDialog.show(context, 'Rest Password ...');
        await _auth.sendPasswordResetEmail(email: email).then((value){
          _hDialog.hide(context);
          _hMessage.logMessageWithToast('Password reset email send successfully', true, logName: _logName);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SignInPage()));
        }).catchError((e) {
          _hDialog.hide(context);
          _hMessage.errorMessage(e, logName: _logName);
        });
    }

    void updatePassword(String password)async{
      _hDialog.show(context, 'Update Password ...');
      await _auth.currentUser!.updatePassword(password).then((value) {
        _hDialog.hide(context);
        _hMessage.logMessageWithToast('Password updated successfully', true, logName: _logName);
        Navigator.pop(context);
      }).catchError((e) {
        _hDialog.hide(context);
        _hMessage.errorMessage(e, logName: _logName);
      });
    }

    void logout() async {
      await _auth.signOut().then((value)
      {
        SharedPreferencesHelper().clear();
        Provider.of<MainProvider>(context,listen: false).removeAllData();
        _hMessage.logMessageWithToast('SIGNOUT', true, logName: _logName);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomePage()));
      }).catchError((e) {
        _hMessage.errorMessage(e, logName: _logName);
      });
    }


}
