import 'dart:convert';

import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/verify_email_model.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {

  String? email;
  final code = ''.obs;

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
      Get.offAllNamed(AppRoute.memberForm);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: data['titel'],
      );
      print(response.body);
    }
  }
}
