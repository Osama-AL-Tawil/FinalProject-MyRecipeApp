import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/SilverGridFixedHeight.dart';

class FutureGridViewWidget extends StatelessWidget {
  dynamic futureFunction;
  dynamic itemBuilder;
  Future<void> Function()? onRefreshFunction;
  FutureGridViewWidget({Key? key,required this.futureFunction,required this.itemBuilder,required onRefreshFunction}) : super(key: key);
  List? data;
  @override
  Widget build(BuildContext context) {
     return  FutureBuilder(
        future:futureFunction ,
        builder: (context, snapshot) {
          if(data != null){
            return GridView.builder(
              //shrinkWrap: true,
              itemCount:data!.length,
              itemBuilder: (context,index)=>itemBuilder(data![index]),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                // mainAxisSpacing: 40,
                // crossAxisSpacing: 24,
                  crossAxisCount: 2,height:150),

            );
          }else if(snapshot.connectionState.name == 'done' && data==null){
            return Container(alignment:Alignment.center,child: const Text('No data available'));
          }
          else{
            return Container(alignment:Alignment.center,child: const CircularProgressIndicator(),);
          }
        });

  }
}
