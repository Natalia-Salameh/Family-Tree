import 'dart:convert';

import 'package:family_tree_application/controller/member_form_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/login_model.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final MemberFormController memberFormController =
      Get.put(MemberFormController());
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

    try {
      var response = await NetworkHandler.postRequest(
        AppLink.login,
        loginData.toJson(),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await NetworkHandler.storeToken(data["token"]);
        await NetworkHandler.storeExpirationDate(data["expiration"]);
        print(response.body);

        var legacyResponse = await NetworkHandler.getRequest(
          AppLink.memberLegacy,
          includeToken: true,
        );
        var profileData = json.decode(legacyResponse.body);

        if (profileData['titel'] == "member doesn't exist") {
          Get.offAllNamed(AppRoute.memberForm);
        } else if (profileData['titel'] == "This User doesn't have a Legacy") {
          Get.offAllNamed(AppRoute.diary);
        } else {
          Get.offAllNamed(AppRoute.home);
        }
      } else if (data['titel'] == "Your Email is Not Verified.") {
        Get.defaultDialog(
          title: "sorry".tr,
          middleText: "email_not_verified".tr,
          confirm: TextButton(
            onPressed: () {
              Get.toNamed(AppRoute.verifyCode, arguments: {
                'email': usernameController.text,
              });
            },
            child: Text("66".tr,
                style: const TextStyle(color: CustomColors.black)),
          ),
          cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("67".tr,
                style: const TextStyle(color: CustomColors.black)),
          ),
        );
      } else {
        String errorMessage = data["invalid_login"] ?? "invalid_login".tr;
        Get.defaultDialog(
          title: "65".tr,
          middleText: errorMessage.tr,
        );
        print(response.body);
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred. Please try again later.",
      );
      print('Error: $e');
    } finally {
      Get.back(); // Close the loading dialog
    }
  }

  logout() async {
    await NetworkHandler.deleteToken();
    Get.offAllNamed(AppRoute.getStarted);
  }
}
