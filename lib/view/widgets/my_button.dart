// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:family_tree_application/constants/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.myCustomColor, //
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 146, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
                color: CustomColors.myCustomColor,
                width: 2), // Border color and width
            elevation: 4, // Shadow depth
          ),
          child: Text(
            'Login',
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
