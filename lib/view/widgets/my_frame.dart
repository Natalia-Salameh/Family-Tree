// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final String imagePath;
  const Frame({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromARGB(255, 217, 214, 214),
        ),
      ),
      child: Image.asset(
        imagePath,
        height: 20,
      ),
    );
  }
}
