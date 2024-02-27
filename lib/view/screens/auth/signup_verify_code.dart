// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../widgets/verify_button.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool _onEditing = true;
  String? _code;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context), // Go back
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.1),
                  child: Text(
                    "Verify code",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Text(
                  "We have sent an email to your email \n    account with a  verification code!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Center(
                        child: Text(
                          'Enter your code',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    VerificationCode(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).primaryColor),
                      keyboardType: TextInputType.number,
                      underlineColor: Colors
                          .amber, // If this is null it will use primaryColor: Colors.red from Theme
                      length: 4,
                      cursorColor: Colors
                          .blue, // If this is null it will default to the ambient
                      // clearAll is NOT required, you can delete it
                      // takes any widget, so you can implement your design
                      clearAll: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'clear all',
                          style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue[700]),
                        ),
                      ),
                      margin: EdgeInsets.all(screenHeight * 0.02),
                      onCompleted: (String value) {
                        setState(() {
                          _code = value;
                        });
                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Center(
                        child: _onEditing
                            ? const Text('Please enter full code')
                            : Text('Your code: $_code'),
                      ),
                    ),
                  ],
                ),
                VerifyButton(
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
