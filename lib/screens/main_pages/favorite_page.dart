import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/app_constants.dart';
import 'package:recipes_project/models/favorite_s_model.dart';
import 'package:recipes_project/widgets/button_widget.dart';
import 'package:recipes_project/widgets/list_items/favorite_list_item.dart';
import 'package:recipes_project/widgets/to_signin_widget.dart';

import '../../firebase/auth_repository.dart';
import '../../helpers/SilverGridFixedHeight.dart';
import '../../models/recipe_model.dart';
import '../../providers/main_provider.dart';
import '../../widgets/custom_widget/refresh_widget.dart';
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<FavoriteSModel>? data ;
  final isAuth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    loadData(); //load data
  }

  @override
  Widget build(BuildContext context) {
    data= Provider.of<MainProvider>(context,listen: true).favoriteList;
    return isAuth!=null?RefreshWidget(
        mainWidget:  GridView.builder(
          itemCount:data==null?0:data!.length,
          itemBuilder: (context,index)=>FavoriteListItem(favorite: data![index]
            ,onPressed: (){removeFromFavorite(data![index].docId.toString());},),
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              height:listHeight
          ),

        ), onRefresh: onRefresh, data: data) :
          const ToSignInWidget(message: 'You must to signIn to add recipes in favorite');
  }

  loadData() async {
    if(isAuth!=null){
      Provider.of<MainProvider>(context, listen: false).getFavorite(context);
    }
  }

  Future<void> onRefresh() async {
    loadData();
  }

  removeFromFavorite(String docId) {
    final isAuth = AuthRepository(context).checkUserIfAuth();
    if(isAuth){
      Provider.of<MainProvider>(context, listen: false).removeFromFavorite(context,docId);
    }
  }

}

