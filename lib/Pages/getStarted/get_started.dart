// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:family_tree_application/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  SizedBox(
                    width: 430,
                    height: 81,
                    child: Text(
                      'Lets Get Started With',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.heebo(
                        color: Color(0xFF212121),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 0,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 110,
                    child: Text(
                      'Ajial',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playball(
                        color: Color(0xFF212121),
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/loginpage');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.myCustomColor, //
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 159, vertical: 16),
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SignUpPage');
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
