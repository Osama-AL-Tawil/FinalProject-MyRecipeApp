import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: Alignment.center, children: [
          SvgPicture.asset('assets/auth_screen_bg.svg',
              width: MediaQuery.of(context).size.width),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: SvgPicture.asset('assets/ic_chef_a.svg'),
          ),
        ]),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
