// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import 'on_boarding3.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.26),
        child: Column(
          children: [
            Image.asset(
              AppImageAsset.onBoardingImageTwo,
              height: 300,
              width: 400,
            ),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: SizedBox(
                  width: 430,
                  height: 81,
                  child: Text(
                    "3".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
