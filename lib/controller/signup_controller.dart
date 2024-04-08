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
      Get.defaultDialog(
        title: "Error",
        middleText: data['titel'],
      );
      print(response.body);
    }
  }
}
