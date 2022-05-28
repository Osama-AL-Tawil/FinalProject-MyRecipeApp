// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DropdownListWidget extends StatefulWidget {
//   String? hint;
//   List items;
//   Object dataModel;
//   DropdownListWidget({Key? key,required this.items,required this.dataModel,this.hint}) : super(key: key);
//
//   @override
//   State<DropdownListWidget> createState() => _DropdownListWidgetState();
// }
//
// class _DropdownListWidgetState extends State<DropdownListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width-30,
//       child:DropdownButtonFormField2(
//         decoration: InputDecoration(
//           //Add isDense true and zero Padding.
//           //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
//           isDense: true,
//           contentPadding: EdgeInsets.zero,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//
//         ),
//         isExpanded: true,
//         hint: const Text(
//           'Select Recipe Category',
//           style: TextStyle(fontSize: 15),
//         ),
//         icon: const Icon(
//           Icons.arrow_drop_down,
//           color: Colors.black45,
//         ),
//         iconSize: 30,
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         items: widget.items.map((item) =>
//             DropdownMenuItem<dynamic>(
//               value: item,
//               child: Text(item.name.en.toString(),
//                 style: const TextStyle(fontSize: 14),),
//             )).toList(),
//         validator: (value) {
//           if (value == null) {
//             return 'Please select Category';
//           }
//         },
//         onChanged: (value) {
//           var data= value as CategoryModel;
//           selectedCategory={'id':data.id!,'name':data.name.en.toString()};
//           //log(data.name.en.toString());
//           //Do something when changing the item if you want.
//         },
//
//       ),)
//     ;
//   }
// }
//
