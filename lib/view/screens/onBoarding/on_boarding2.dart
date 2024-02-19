// ignore_for_file: prefer_const_constructors

import 'package:family_tree_application/constants/imageasset.dart';
import 'package:family_tree_application/constants/routes.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Image.asset(
              AppImageAsset.onBoardingImageTwo,
              height: 300,
              width: 400,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: 430,
                  height: 81,
                  child: Text(
                    'Bridging Distances,\n Uniting Hearts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 110),
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
                        color: Colors.grey,
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
