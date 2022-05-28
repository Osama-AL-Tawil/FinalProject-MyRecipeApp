import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/firebase/firestore_repository.dart';
import 'package:recipes_project/models/category_model.dart';
import 'package:recipes_project/widgets/list_items/category_list_item.dart';
import 'package:recipes_project/widgets/custom_widget/refresh_widget.dart';

import '../../helpers/SilverGridFixedHeight.dart';
import '../../providers/main_provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategoryModel>? categories ;

  @override
  void initState() {
    super.initState();
    Provider.of<MainProvider>(context, listen: false).getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    categories = Provider.of<MainProvider>(context,listen: true).categories;
    Future<void> onRefresh() async {
      Provider.of<MainProvider>(context, listen: false).getCategories(context);
    }

    return RefreshWidget(
      mainWidget: GridView.builder(
        itemCount:categories==null?0:categories!.length,
        itemBuilder: (context,index)=>CategoryListItem(categories![index]),
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            crossAxisCount: 2,
            height:150
        ),),
      onRefresh: onRefresh,
      data: categories);


}

}

