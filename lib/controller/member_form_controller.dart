import 'package:family_tree_application/model/member_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/enums.dart';

class MemberFormController extends GetxController {
  final selectedGender = Rx<Gender?>(null);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void updateGender(Gender? gender) {
    selectedGender.value = gender;
  }

  addMember() async {
    MemberFormModel memberFormModel = MemberFormModel(
        firstName: firstNameController.text,
        secondName: secondNameController.text,
        thirdName: thirdNameController.text,
        gender: selectedGender.string,
        dateOfBirth: DateTime.parse(dateController.text),
        dateOfDeath: DateTime.parse(dateController.text));
  }
}
