// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';

import 'splash3_screen.dart';

class Splash2Screen extends StatelessWidget {
  const Splash2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Column(
          children: [
            Text(
              'Welcome to Ajial',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF098666),
                fontSize: 40,
                fontFamily: 'Fira Sans Condensed',
                fontWeight: FontWeight.w500,
                height: 4,
              ),
            ),
            Image.asset(
              'lib/images/tree-image.png',
              height: 300,
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'Discover Your Roots, \nHonor All Branches',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24,
                  fontFamily: 'Arial Rounded MT Bold',
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  letterSpacing: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/splash3screen');
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
                  SizedBox(width: 8),
                  Container(
                    width: 80,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
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
