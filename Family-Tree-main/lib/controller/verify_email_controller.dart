import 'dart:convert';

import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/controller/signup_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/login_model.dart';
import 'package:family_tree_application/model/verify_email_model.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  String? email;
  final code = ''.obs;
  SignUpController signUpController = Get.find();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    Get.put(ProgressController());
  }

  verifyEmail() async {
    VerifyEmailModel verifyEmailData = VerifyEmailModel(
      email: email!,
      code: code.value,
    );

    var response = await NetworkHandler.postRequest(
      AppLink.codeVerification,
      verifyEmailData.toJson(),
    );

    var data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      LoginModel loginData = LoginModel(
        userName: email!,
        password: signUpController.passwordController.text,
      );
      var tokenResponse = await NetworkHandler.postRequest(
        AppLink.login,
        loginData.toJson(),
      );
      var tokendata = json.decode(tokenResponse.body);
      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        await NetworkHandler.storeToken(tokendata["token"]);
        await NetworkHandler.storeExpirationDate(tokendata["expiration"]);
        print(tokenResponse.body);
        Get.offAllNamed(AppRoute.memberForm);
      } else {
        handleErrorResponse(data);
        print(tokenResponse.body);
      }
    } else {
      handleErrorResponse(data);
      print(response.body);
    }
  }

  void handleErrorResponse(Map<String, dynamic> data) {
    if (data['titel'] == "The verification code is incorrect.") {
      Get.defaultDialog(
        title: "65".tr,
        middleText: "verification_code_incorrect".tr,
      );
    } else {
      // Default error handling
      Get.defaultDialog(
        title: "65".tr,
        middleText: data[
            'titel'], // Assume 'titel' is directly translatable or add more conditions if needed
      );
    }
  }
}
