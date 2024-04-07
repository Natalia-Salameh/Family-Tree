import 'dart:convert';

import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/crud.dart';
import 'package:family_tree_application/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() async {
    LoginModel loginData = LoginModel(
      userName: usernameController.text,
      password: passwordController.text,
    );
    var response = await NetworkHandler.postRequest(
      AppLink.login,
      loginData.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      await NetworkHandler.storeToken(data["token"]);
      print(response.body);
      Get.offNamed(AppRoute.home);
    } else {
      print(response.body);
    }
  }

  logout() async {
    await NetworkHandler.deleteToken();
    Get.offAllNamed(AppRoute.getStarted);
  }
}
