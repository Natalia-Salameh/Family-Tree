// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyButton extends StatelessWidget {
  final Function()? onTap;
  const VerifyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.06),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor, //
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
                color: CustomColors.primaryColor,
                width: 2), // Border color and width
            elevation: 4, // Shadow depth
          ),
          child: Text(
            'Verify',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
