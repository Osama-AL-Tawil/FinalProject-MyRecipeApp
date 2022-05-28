class FavoriteModel {
  String userId;
  String recipeId;
  String? id;

  FavoriteModel(this.userId,this.recipeId);
  toMap(){
    return {'userId':userId,'recipeId':recipeId};
  }

  FavoriteModel.fromMap(String docId,Map<String,dynamic> map)
      :userId=map['userId'],
        recipeId=map['recipeId'],
        id=docId;





}