import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/app_constants.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/widgets/custom_widget/refresh_widget.dart';

import '../../firebase/auth_repository.dart';
import '../../firebase/firestore_repository.dart';
import '../../helpers/SilverGridFixedHeight.dart';
import '../../models/recipe_model.dart';
import '../../widgets/list_items/recipe_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel>? data ;

  @override
  void initState() {
    super.initState();
    loadData(); //load data
  }

  @override
  Widget build(BuildContext context) {
    data= Provider.of<MainProvider>(context,listen: true).homeList;
    return RefreshWidget(
        mainWidget:  GridView.builder(
           itemCount:data==null?0:data!.length,
           itemBuilder: (context,index)=>RecipeListItem(isHome:true,recipe:data![index]
             ,onClick: (){addToFavorite(data![index].id.toString());},),
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              height:listHeight
         ),

    ), onRefresh: onRefresh, data: data) ;

  }

  loadData() async {
    Provider.of<MainProvider>(context, listen: false).getHomeData(context);
  }

  Future<void> onRefresh() async {
    loadData();
  }

  addToFavorite(String recipeId) async{
    final isAuth = AuthRepository(context).checkUserIfAuth();
    if(isAuth){
      await FirestoreRepository(context).addToFavorite(recipeId);
    }
  }


}

