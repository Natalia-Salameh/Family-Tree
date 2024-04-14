import 'dart:convert';

import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;
  signUp() async {
    SignupModel signupData = SignupModel(
      userName: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    var response = await NetworkHandler.postRequest(
      AppLink.signup,
      signupData.toJson(),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Get.toNamed(AppRoute.verifyCode, arguments: {
        'email': emailController.text,
      });
    } else {
      // Determine the appropriate message key based on the 'titel' from the response
      String messageKey;
      if (data['titel'] ==
          'The email address is already in use. Please use a different email address.') {
        messageKey = 'email_in_use';
      } else if (data['titel'] ==
          'Email sent successfully. Please check your email.') {
        messageKey = 'email_sent';
      } else if (data['UserName']?.first ==
          'The username must be between 6 and 100 characters long.') {
        messageKey = 'username_length_error';
      } else {
        messageKey = 'unknown_error'; // Handle any unexpected messages
      }

      Get.defaultDialog(
        title: "65".tr, // Assuming you want to translate "Error" as well
        middleText: messageKey.tr,
      );
      print(response.body);
    }
  }
}
