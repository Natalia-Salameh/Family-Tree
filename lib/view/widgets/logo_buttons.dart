// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:family_tree_application/classes/sigupwithgoogle.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:flutter/material.dart';

import 'my_frame.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
              child: InkWell(
                onTap: () {},
                child: Frame(imagePath: AppImageAsset.google),
              ),
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
              child: InkWell(
                onTap: () {
                  // Handle Facebook button tap
                  print("Facebook button tapped");
                },
                child: Frame(imagePath: AppImageAsset.facebook),
              ),
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
              child: InkWell(
                onTap: () {
                  // Handle Apple button tap
                  print("Apple button tapped");
                },
                child: Frame(imagePath: AppImageAsset.apple),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
