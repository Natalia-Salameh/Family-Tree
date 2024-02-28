// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../core/constants/routes.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.22),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 430,
                  height: 81,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: Text(
                      'Lets Get Started With',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.heebo(
                        color: CustomColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 0,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Text(
                    'Ajial',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playball(
                      color: CustomColors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoute.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor, //
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 143, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                      color: CustomColors.primaryColor,
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
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoute.signUp);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor, //
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 136, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                      color: CustomColors.primaryColor,
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
