import 'package:flutter/cupertino.dart';

import '../../app_constants.dart';


class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
          child: Text(
            title,
            style: const TextStyle(color: primaryColor, fontSize: 30),
            softWrap: true,
          ),
        ));
  }
}