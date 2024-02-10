// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously


import 'package:family_tree_application/Pages/splash/splash2_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoSplash2();
  }

  _navigatetoSplash2() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Splash2Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'lib/images/ajial.png',
            height: 250,
            width: 250,
          ),
        ]),
      ),
    );
  }
}
