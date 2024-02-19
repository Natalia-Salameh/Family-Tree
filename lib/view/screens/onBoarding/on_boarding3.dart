// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/constants/imageasset.dart';
import 'package:family_tree_application/constants/routes.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 170),
        child: Column(
          children: [
            Image.asset(
              AppImageAsset.onBoardingImageThree,
              height: 300,
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                  width: 430,
                  height: 81,
                  child: Text(
                    'Every Click, A Story Unfolds',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: () {
                  // sese ba3deen
                  Navigator.of(context).pushNamed(AppRoute.getStarted);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.myCustomColor, //
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                      color: CustomColors.myCustomColor,
                      width: 2), // Border color and width
                  elevation: 4, // Shadow depth
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
