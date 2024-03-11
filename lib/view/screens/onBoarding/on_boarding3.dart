// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/get_started.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.21),
        child: Column(
          children: [
            Image.asset(
              AppImageAsset.onBoardingImageThree,
              height: 300,
              width: 400,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.08),
              child: SizedBox(
                  width: 430,
                  height: 81,
                  child: Text(
                    'Every Click, A Story Unfolds',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.07),
              child: ElevatedButton(
                onPressed: () {
                  // sese ba3deen
                  Get.to(GetStarted());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor, //
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                      color: CustomColors.primaryColor,
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
