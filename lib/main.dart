// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/auth/get_started.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/user_form.dart';

import 'package:flutter/material.dart';

import 'view/screens/splash_screen.dart';
import 'view/screens/onBoarding/on_boarding1.dart';
import 'view/screens/onBoarding/on_boarding2.dart';
import 'view/screens/onBoarding/on_boarding3.dart';
import 'view/screens/auth/login.dart';
import 'view/screens/auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          AppRoute.splash: (context) => SplashScreen(),
          AppRoute.onBoarding1: (context) => OnBoarding1(),
          AppRoute.onBoarding2: (context) => OnBoarding2(),
          AppRoute.onBoarding3: (context) => OnBoarding3(),
          AppRoute.getStarted: (context) => GetStarted(),
          AppRoute.login: (context) => Login(),
          AppRoute.signUp: (context) => SignUp(),
          AppRoute.form: (context) => UserForm(),
        });
  }
}
