import 'package:flutter/material.dart';
import 'package:recipes_project/widgets/colors.dart';

class RefreshWidget extends StatelessWidget {
  List<dynamic>? data; //this variable get list to check null status to show or hide indicator or message
  Widget mainWidget; //this variable contain widget [ListView, GridView]
  Future<void> Function() onRefresh; //contain refresh function
  String? message; //contain message when show when array isEmpty
   RefreshWidget({Key? key,
     required this.mainWidget,
     required this.onRefresh,
     required this.data,
     this.message='No data available',
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:onRefresh,
      child:data==null?Container(alignment:Alignment.center,child: const CircularProgressIndicator(),)
          :data!=null&&data!.isEmpty?Stack(alignment:Alignment.center,children: [ListView(),Text(message.toString())],)
          :data!=null&&data!.isNotEmpty? mainWidget
          :const SizedBox()
      ,);
  }
}
