// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';


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
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoute.home);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.myCustomColor, //
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
                color: CustomColors.myCustomColor,
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
