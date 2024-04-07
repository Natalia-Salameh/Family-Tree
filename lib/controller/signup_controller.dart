import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/crud.dart';
import 'package:family_tree_application/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;

  signUp() async {
    SignupModel signupData = SignupModel(
      userName: usernameController.text,
      email: passwordController.text,
      password: confirmPasswordController.text,
    );

    var response = await NetworkHandler.postRequest(
      AppLink.signup,
      signupData.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Get.offAll(AppRoute.verifyCode);
    } else {
      print(response.body);
    }
  }
}
