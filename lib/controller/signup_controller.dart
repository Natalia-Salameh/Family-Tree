import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/screens/auth/signup_verify_code.dart';

class SignUpController extends GetxController {
  Future<Map<String, dynamic>> loadResponse() async {
    String jsonString = await rootBundle.loadString('assets/responses.json');
    return json.decode(jsonString);
  }

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;
  void signUserUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', true);
    await prefs.setString('registeredUser',
        usernameController.text); // Save the registered username
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text) {
        // Load responses from JSON
        Map<String, dynamic> responses = await loadResponse();

        // Check for the condition to simulate a failure
        if (usernameController.text == "alreadyExists") {
          // Simulate failure due to user already exists
          Map<String, dynamic> registrationFailure =
              responses['registration']['failure'];
          Get.snackbar("Error", registrationFailure['message'],
              snackPosition: SnackPosition.BOTTOM);
        } else {
          // Simulate successful registration
          Map<String, dynamic> registrationSuccess =
              responses['registration']['success'];
          Get.snackbar("Registration", registrationSuccess['message'],
              snackPosition: SnackPosition.TOP);

          // Navigate to verification code screen
          Get.to(() => VerifyCode());
        }
      } else {
        Get.snackbar(
            "Error", "Please ensure all fields are filled and passwords match.",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
