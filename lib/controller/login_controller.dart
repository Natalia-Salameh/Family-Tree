import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  void logUserIn() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Get.offAllNamed(AppRoute.home);
      }
    }
  }
}
