import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:recipes_project/providers/main_provider.dart';
import 'package:recipes_project/screens/splash.dart';
import 'package:recipes_project/widgets/password_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  FirebaseAuth auth  =FirebaseAuth.instance;

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PasswordToggleProvider()),
          ChangeNotifierProvider(create: (_) => MainProvider()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  fontFamily: 'PlusJakartaSans'),
              home: const SplashScreen() //TestPage()//
              );
        }));
  }
}
