import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/widgets/colors.dart';
import '../../helpers/SilverGridFixedHeight.dart';
import '../../models/recipe_model.dart';
import '../app_constants.dart';
import '../firebase/auth_repository.dart';
import '../widgets/custom_widget/refresh_widget.dart';
import '../widgets/list_items/recipe_list_item.dart';

class CategoryDetailsPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const CategoryDetailsPage(this.categoryName,this.categoryId,{Key? key}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  List<RecipeModel>? data ;

  @override
  Widget build(BuildContext context) {
    getRecipes();
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName),backgroundColor: primaryColor,),
      body:  RefreshWidget(
        mainWidget:  GridView.builder(
          itemCount:data==null?0:data!.length,
            itemBuilder: (context,index)=>RecipeListItem(isHome:true,recipe:data![index]
              ,onClick: (){addToFavorite(data![index].id.toString());},),
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 2,
                height:listHeight
            ),
         ), onRefresh: onRefresh, data: data)
        );

  }

  Future<void> onRefresh() async{
    setState(() {});
  }
  getRecipes()async{
    data??=await FirestoreRepository(context).getRecipes(categoryId: widget.categoryId);
    setState(() {});
  }

  addToFavorite(String recipeId) async{
    final isAuth = AuthRepository(context).checkUserIfAuth();
    if(isAuth){
      await FirestoreRepository(context).addToFavorite(recipeId);
    }
  }

}

