// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final String imagePath;
  const Frame({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenHeight * 0.01, vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 217, 214, 214),
        ),
      ),
      child: Image.asset(
        imagePath,
        height: 20,
      ),
    );
  }
}
