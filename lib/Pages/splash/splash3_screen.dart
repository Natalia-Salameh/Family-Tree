// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'splash4_screen.dart';

class Splash3 extends StatelessWidget {
  const Splash3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 230),
        child: Column(
          children: [
            Image.asset(
              'lib/images/bridge.png',
              height: 300,
              width: 400,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SizedBox(
                  width: 430,
                  height: 81,
                  child: Text(
                    'Bridging Distances,\n Uniting Hearts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontFamily: 'Arial Rounded MT Bold',
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 60),
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
                      Navigator.pushNamed(context, '/splash4screen');
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
