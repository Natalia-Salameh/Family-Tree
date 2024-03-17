import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';

import '../../widgets/verify_button.dart';

class VerifyCode extends StatelessWidget {
  final _onEditing = true.obs;
  final _code = ''.obs;

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
                  onPressed: () => Get.back(),
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
                        _code.value = value;
                      },
                      onEditing: (bool value) {
                        _onEditing.value = value;
                        if (!_onEditing.value) FocusScope.of(context).unfocus();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Center(
                        child: Obx(() => _onEditing.value
                            ? const Text('Please enter full code')
                            : Text('Your code: ${_code.value}')),
                      ),
                    ),
                    VerifyButton(
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
