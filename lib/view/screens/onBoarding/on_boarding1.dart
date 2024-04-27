// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/imageasset.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: Text(
                "2".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.primaryColor,
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                  height: 4,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: Image.asset(
                AppImageAsset.onBoardingImageOne,
                height: 300,
                width: 300,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Text(
                  "1".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
