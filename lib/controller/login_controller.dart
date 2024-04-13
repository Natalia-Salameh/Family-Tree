import 'dart:convert';

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  login() async {
    LoginModel loginData = LoginModel(
      userName: usernameController.text,
      password: passwordController.text,
    );

    Get.dialog(const Center(
        child: CircularProgressIndicator(
            backgroundColor: CustomColors.white,
            color: CustomColors.primaryColor)));

    var response = await NetworkHandler.postRequest(
      AppLink.login,
      loginData.toJson(),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      await NetworkHandler.storeToken(data["token"]);
      Get.offAllNamed(AppRoute.home);
      print(response.body);
    } else if (data['titel'] == "Your Email is Not Verified.") {
      // consider changing the check to a constant key or handling differently
      Get.defaultDialog(
        title: "sorry".tr,
        middleText: "email_not_verified".tr,
        confirm: TextButton(
          onPressed: () {
            Get.toNamed(AppRoute.verifyCode, arguments: {
              'email': usernameController.text,
            });
          },
          child:
              Text("66".tr, style: const TextStyle(color: CustomColors.black)),
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child:
              Text("67".tr, style: const TextStyle(color: CustomColors.black)),
        ),
      );
    } else {
      String errorMessage = data["invalid_login"] ??
          "invalid_login".tr; // Handle null with a default
      Get.defaultDialog(
        title: "65".tr,
        // Assuming you have "Error" as a translatable string for the title
        middleText: errorMessage.tr,
      );
      print(response.body);
    }
  }

  logout() async {
    await NetworkHandler.deleteToken();
    Get.offAllNamed(AppRoute.getStarted);
  }
}
