import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Future<Map<String, dynamic>> loadResponse() async {
    String jsonString = await rootBundle.loadString('assets/responses.json');
    return json.decode(jsonString);
  }

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  void logUserIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('isRegistered') ?? false;
    String registeredUser = prefs.getString('registeredUser') ?? '';

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (isRegistered && usernameController.text == registeredUser) {
        // Proceed with login if the user is registered
        Get.offAllNamed(AppRoute.home);
      } else {
        // If not registered or username doesn't match, show an error
        Get.snackbar("Login Failed",
            "User not registered or username does not match. Please sign up first.",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
