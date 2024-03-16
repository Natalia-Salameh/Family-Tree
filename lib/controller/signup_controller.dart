import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/auth/signup_verify_code.dart';

class SignUpController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;
  void signUserUp() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text) {
        Get.to(() => VerifyCode());
      }
    }
  }
}
