import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/helpers/shared_preferences.dart';
import 'package:recipes_project/models/user_model.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/screens/edit_profile.dart';
import 'package:recipes_project/screens/my_recipes.dart';
import 'package:recipes_project/widgets/profile_widget.dart';
import 'package:sizer/sizer.dart';

import '../../app_constants.dart';
import '../../firebase/auth_repository.dart';
import '../../widgets/to_signin_widget.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  UserModel? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final isAuth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<MainProvider>(context,listen: true).user;
    var width = MediaQuery.of(context).size.width;
    return widget.user!=null&& isAuth!=null?Column(
      children: [
        Stack(
          children: [
            Container(
              width: width,
              height: 35.h,
              color: primaryColor,
            ),
            Positioned(
              top: 5.h,
              child: SizedBox(width: width,
                  child: Row(
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 10),child: Text(
                        'Profile',
                        style: TextStyle(fontSize: 20.sp, color: whiteColor),
                      ),),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));}, child: const Text(
                              'Edit',
                              style: TextStyle(color: whiteColor),
                            )),
                          ))
                    ],
                  )),
            ),
            Positioned(
                top: 12.h,
                child: SizedBox(width: width,child:
                Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
                  Container(child: widget.user!.profileImage!=null&& widget.user!.profileImage!=''?
                  CircleAvatar(backgroundImage:NetworkImage(widget.user!.profileImage!)
                    ,backgroundColor:Colors.white,radius: 55,)
                      :const CircleAvatar(backgroundImage:AssetImage(profilePlaceholder)
                    ,backgroundColor:Colors.white,radius: 55,)
                  ),
                  // CircleAvatar(backgroundImage:NetworkImage(profileImage),backgroundColor:Colors.black,radius: 55,),
                  SizedBox(height: 2.h,),
                  Text(widget.user!.userName, style: TextStyle(fontSize: 15.sp, color: whiteColor),),

                ],),)
            )
          ],
        ),
        SizedBox(height:1.h),
        ProfileWidget(title: 'E-Mail', description:widget.user!.email, iconPath: 'assets/ic_email.svg'),
        SizedBox(height:1.h),
        ProfileWidget(title: 'Phone', description:widget.user!.phone, iconPath: 'assets/ic_phone.svg'),
        SizedBox(height:1.h),
        ProfileWidget(title: 'MyRecipes', iconPath: 'assets/ic_myrecipe.svg',withArrow:true
          ,pressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MyRecipePage()));},),
        SizedBox(height:1.h),
        ProfileWidget(title: 'Logout', iconPath: 'assets/ic_logout.svg',withArrow: true,pressed: (){
          AuthRepository(context).logout();
        },),
      ],

    ):isAuth==null?
    const ToSignInWidget(message: 'You must to signIn to show your profile'):
    Container(alignment:Alignment.center,child: const CircularProgressIndicator(),);

  }

  //get user data from sharedPreferences
  getUserData (BuildContext context)async{
    if(widget.user==null && isAuth!=null){
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Provider.of<MainProvider>(context,listen: false).getUserData(context,userId);
    }
  }


}


