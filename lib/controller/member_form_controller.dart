import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/enums.dart';

class MemberFormController extends GetxController {
  final selectedGender = Rx<Gender?>(null);
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void updateGender(Gender? gender) {
    selectedGender.value = gender;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
