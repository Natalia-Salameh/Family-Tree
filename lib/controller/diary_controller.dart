import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryController extends GetxController {
  final TextEditingController educationController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController diaryController = TextEditingController();

  getStarted() async {
    DiaryModel diaryData = DiaryModel(
      education: educationController.text,
      work: workController.text,
      legacyStory: diaryController.text,
    );

    var response = await NetworkHandler.postRequest(
      AppLink.diary,
      diaryData.toJson(),
      includeToken: true,
    );
    String? token = await NetworkHandler.getToken();
    print(token);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoute.home);
      print(response.body);
    } else {
      Get.defaultDialog(
        title: "65".tr,
        middleText: 'Legacy for the user already exist'.tr,
      );
      print(response.body);
    }
  }
}
