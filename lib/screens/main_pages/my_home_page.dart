import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/screens/main_pages/profile_page.dart';

import '../../app_constants.dart';
import '../../firebase/auth_repository.dart';
import '../../providers/main_provider.dart';
import '../add_category.dart';
import '../add_recipe.dart';
import '../auth_pages/sign_in.dart';
import 'categories_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title=''}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const CategoriesPage(),
    const FavoritePage(),
    ProfilePage(),
  ];

  final screenNames = ['Home', 'Categories', 'Favorite', 'Profile'];



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MainProvider>(context,listen: true).user;
    bool isHomePage = currentIndex == 0;
    AppBar? showAppBar;
    if(screenNames[currentIndex]=='Profile'){
      showAppBar=null;
    }else{
      showAppBar=AppBar(
          title: Text(screenNames[currentIndex]),
          backgroundColor: primaryColor,
          actions: isHomePage ? <Widget>[

            IconButton(
              icon: SvgPicture.asset('assets/ic_add.svg'),
              onPressed: () {
                final isAuth= AuthRepository(context).checkUserIfAuth();
                if(isAuth){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddRecipe()));
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestPage()));
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignInPage()));
                }
              },
            ),
            user!=null&&user.role=='admin'?
            IconButton(
              icon: SvgPicture.asset('assets/ic_add_category.svg'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddCategory()));
              },
            ):const SizedBox(width: 0,height: 0,),
          ] : null);
    }
    return Scaffold(
      appBar: showAppBar,

      //To Save Screen State
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/navigation/ic_nav_home.svg"),
              label: "Home",
              activeIcon:
              SvgPicture.asset("assets/navigation/ic_nav_home_c.svg")),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/navigation/ic_nav_category.svg"),
              label: "Categories",
              activeIcon:
              SvgPicture.asset("assets/navigation/ic_nav_category_c.svg")),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/navigation/ic_nav_favorite.svg"),
              label: "Favorite",
              activeIcon:
              SvgPicture.asset("assets/navigation/ic_nav_favorite_c.svg")),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/navigation/ic_nav_profile.svg"),
              label: "Profile",
              activeIcon:
              SvgPicture.asset("assets/navigation/ic_nav_profile_c.svg")),
        ],
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFFFA4B4B),
        unselectedItemColor: const Color(0xFFC8C7CC),
        selectedFontSize: 13,
      ),
    );
  }
}