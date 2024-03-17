import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LegacyEditController extends GetxController {
  var fullNameController = TextEditingController().obs;
  var dateController = TextEditingController().obs;
  var educationController = TextEditingController().obs;
  var workController = TextEditingController().obs;
  var diaryController = TextEditingController().obs;

  @override
  void onClose() {
    fullNameController.value.dispose();
    dateController.value.dispose();
    educationController.value.dispose();
    workController.value.dispose();
    diaryController.value.dispose();
    super.onClose();
  }
}
