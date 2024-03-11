// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/view/screens/Legacy/legacy.dart';
import 'package:family_tree_application/view/screens/Legacy/legacy_edit.dart';
import 'package:family_tree_application/view/screens/auth/get_started.dart';
import 'package:family_tree_application/view/screens/auth/signup_verify_code.dart';
import 'package:family_tree_application/view/screens/home/home.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/user_form.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      initialRoute: "/splashscreen",
      getPages: [
        GetPage(name: '/splashscreen', page: () => SplashScreen()),
        GetPage(name: '/onBoarding1', page: () => OnBoarding1()),
        GetPage(name: '/onBoarding2', page: () => OnBoarding2()),
        GetPage(name: '/onBoarding3', page: () => OnBoarding3()),
        GetPage(name: '/GetStarded', page: () => GetStarted()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/verifyCode', page: () => VerifyCode()),
        GetPage(name: '/', page: () => Home()),
        // GetPage(name: AppRoute.search, page: () => Search()),

        GetPage(name: '/form', page: () => UserForm()),
        GetPage(name: '/legacyEdit', page: () => LegacyEdit()),
        GetPage(name: '/legacy', page: () => Legacy()),
      ],
    );
  }
}
