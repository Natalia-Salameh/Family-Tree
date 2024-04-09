// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors


import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class SignButton extends StatelessWidget {
  final Function()? onTap;
  const SignButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor, //
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 130, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
                color: CustomColors.primaryColor,
                width: 2), // Border color and width
            elevation: 4, // Shadow depth
          ),
          child: Text(
            'Register',
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
