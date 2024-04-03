import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:family_tree_application/core/constants/routes.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  void logUserIn() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // API endpoint
      final url =
          Uri.parse('https://ajial.azurewebsites.net/api/Account/Login');
      // Making POST request
      try {
        print('Making API Call to $url');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "Username": usernameController.text,
            "Password": passwordController.text,
          }),
        );
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          // Assuming success response includes a token or some identifier
          final responseData = jsonDecode(response.body);
          // You might want to save the token in SharedPreferences or manage it as needed
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogged', true);
          // Navigate to home or next page
          Get.offAllNamed(AppRoute.home);
        } else {
          // Handle login failure
          Get.snackbar("Login Failed", "Invalid username or password.",
              snackPosition: SnackPosition.TOP);
        }
      } catch (e) {
        // Handle error, e.g., no internet connection
        Get.snackbar(
            "Login Error", "An error occurred. Please try again later.",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
