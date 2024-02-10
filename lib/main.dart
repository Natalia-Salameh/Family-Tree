// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/Pages/getStarted/get_started.dart';

import 'package:flutter/material.dart';

import 'Pages/splash/splash1_screen.dart';
import 'Pages/splash/splash2_screen.dart';
import 'Pages/splash/splash3_screen.dart';
import 'Pages/splash/splash4_screen.dart';
import 'view/screens/auth/login.dart';
import 'view/screens/auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/splashscreen': (context) => SplashScreen(),
          '/splash2screen': (context) => Splash2Screen(),
          '/splash3screen': (context) => Splash3(),
          '/splash4screen': (context) => Splash4(),
          '/getStarted': (context) => GetStarted(),
          '/loginpage': (context) => Login(),
          '/SignUpPage': (context) => SignUp(),
        });
  }
}
