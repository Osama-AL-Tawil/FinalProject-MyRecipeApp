import 'package:recipes_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  void saveUserData(UserModel user) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', user.userName);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phone);
    await prefs.setString('role', user.role);
    if(user.profileImage!=null && user.profileImage!=''){
      await prefs.setString('profileImage', user.profileImage!);
    }
  }

  Future<UserModel> getUserData() async{
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
        prefs.getString('email').toString(),
        prefs.getString('userName').toString(),
        prefs.getString('phone').toString(),
        prefs.getString('role').toString(),
        prefs.getString('profileImage').toString()
    );

  }

  asGuest(bool? status)async{
    final prefs = await SharedPreferences.getInstance();
    if(status==null){
      await prefs.setBool('isGuest',true);
    }else{
      await prefs.setBool('isGuest',status);
    }
  }

  Future<bool?> checkIfGuest() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest');
  }

  Future<void> clear() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }



}