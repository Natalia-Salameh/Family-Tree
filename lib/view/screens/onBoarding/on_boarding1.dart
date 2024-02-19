// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:family_tree_application/constants/imageasset.dart';
import 'package:family_tree_application/constants/routes.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'on_boarding2.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Welcome to Ajial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.myCustomColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    height: 4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                AppImageAsset.onBoardingImageOne,
                height: 300,
                width: 250,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Discover Your Roots, \nHonor All Branches',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.myBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
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
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoute.onBoarding2);
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
                    SizedBox(width: 8),
                    Container(
                      width: 80,
                      height: 8,
                      decoration: BoxDecoration(
                        color: CustomColors.myGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
