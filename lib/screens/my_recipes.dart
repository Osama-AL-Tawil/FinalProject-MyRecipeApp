import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/models/recipe_model.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/screens/add_recipe.dart';
import 'package:recipes_project/screens/recipe_details_page.dart';
import 'package:recipes_project/widgets/list_items/my_recipe_list_item.dart';

import '../app_constants.dart';
import '../helpers/SilverGridFixedHeight.dart';
import '../widgets/custom_widget/refresh_widget.dart';

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({Key? key}) : super(key: key);

  @override
  State<MyRecipePage> createState() => _MyRecipePageState();

}

class _MyRecipePageState extends State<MyRecipePage> {
  List<RecipeModel>? data;
  final userId = FirebaseAuth.instance.currentUser!.uid.toString();

  getData(){
    Provider.of<MainProvider>(context,listen: false).getMyRecipeList(context, userId);
  }

  removeRecipe(String id) {
    Provider.of<MainProvider>(context,listen: false).removeRecipe(context, id);
  }

  @override
  Widget build(BuildContext context) {
    data= Provider.of<MainProvider>(context,listen: true).myRecipe;

   if (data == null) {
     getData();
   }

   Future<void> onRefresh() async {
      getData();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Recipe'),backgroundColor: primaryColor,),
      body:RefreshWidget(
        mainWidget:GridView.builder(
          shrinkWrap: false,
          itemCount: data==null?0:data!.length,
          itemBuilder: (context,index)=>MyRecipeListItem(data![index],
            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeDetailsPage(data![index])));},
            onClickDelete:(){removeRecipe(data![index].id.toString());} ,
            onClickEdit:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRecipe(editMode: true,data: data![index],)));} ,),
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(crossAxisCount: 2,height:255),)
        ,
        onRefresh: onRefresh,
        data: data,
      )

    );
  }

}


// RefreshIndicator(
// child: FutureBuilder(future:FirestoreRepository(context).getRecipes(userId:userId).then((value) =>
// {Provider.of<MainProvider>(context,listen: false).setMyRecipeList(value)}) ,
// builder:(context,snapshot){
// if(snapshot.connectionState.name == 'done' && data != null){
// return GridView.builder(
// shrinkWrap: true,
// itemCount: data.length,
// itemBuilder: (context,index)=>MyRecipeListItem(data[index]),
// gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
// crossAxisCount: 2,height:255),
// );
// }else if(snapshot.connectionState.name == 'done' && data==null){
// return Container(alignment:Alignment.center,child: const Text('No data available'));
// }
// else{
// return Container(alignment:Alignment.center,child: const CircularProgressIndicator(),);
// }
// })
// ,onRefresh:onRefresh ,)



// RefreshIndicator(
// onRefresh:onRefresh,
// child: data!=null?GridView.builder(
// shrinkWrap: true,
// itemCount: data.length,
// itemBuilder: (context,index)=>MyRecipeListItem(data[index],
// onClickDelete:(){Provider.of<MainProvider>(context,listen: false).removeRecipe(data[index].id.toString());} ,
// onClickEdit:(){log('message');} ,),
// gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
// crossAxisCount: 2,height:255),
// ):data==null&&isLoading==false?Container(alignment:Alignment.center,child: const Text('No data available')):
// Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)
//
// ,)




// FutureBuilder(future:load(),
// builder:(context,snapshot){
// if(snapshot.connectionState.name == 'done' && data != null){
// return GridView.builder(
// shrinkWrap: false,
// itemCount: data.length,
// itemBuilder: (context,index)=>MyRecipeListItem(data[index],
// onClickDelete:(){Provider.of<MainProvider>(context,listen: false).removeRecipe(data[index].id.toString());} ,
// onClickEdit:(){log('message');} ,),
// gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
// crossAxisCount: 2,height:255),
// );
// }else if(snapshot.connectionState.name == 'done' && data==null){
// return Container(alignment:Alignment.center,child: const Text('No data available'));
// }
// else{
// return Container(alignment:Alignment.center,child: const CircularProgressIndicator(),);
// }
// })



// body:RefreshIndicator(
// onRefresh:onRefresh,
// child:data==null?Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)
// :data.isEmpty?Stack(alignment:Alignment.center,children: [ListView(),const Text('No data available')],)
// :data.isNotEmpty? GridView.builder(
// shrinkWrap: false,
// itemCount: data.length,
// itemBuilder: (context,index)=>MyRecipeListItem(data[index],
// onClickDelete:(){Provider.of<MainProvider>(context,listen: false).removeRecipe(data[index].id.toString());} ,
// onClickEdit:(){log('message');} ,),
// gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(crossAxisCount: 2,height:255),)
// :const SizedBox()
// ,)
