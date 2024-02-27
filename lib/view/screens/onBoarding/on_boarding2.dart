// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';


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
                    'Bridging Distances,\n Uniting Hearts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.myBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 8,
                    decoration: BoxDecoration(
                      color: CustomColors.myCustomColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 80,
                    height: 8,
                    decoration: BoxDecoration(
                      color: CustomColors.myCustomColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.onBoarding3);
                    },
                    child: Container(
                      width: 80,
                      height: 8,
                      decoration: BoxDecoration(
                        color: CustomColors.myGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
