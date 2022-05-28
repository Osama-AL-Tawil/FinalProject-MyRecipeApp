import 'package:recipes_project/models/recipe_model.dart';

class FavoriteSModel{
  String docId;
  RecipeModel recipe;
  FavoriteSModel(this.docId,this.recipe);
  FavoriteSModel.fromMap(String _docId,RecipeModel recipeModel)
      :docId=_docId,
       recipe=recipeModel;
}