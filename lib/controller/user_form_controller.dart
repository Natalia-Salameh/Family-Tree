import 'dart:convert';
import 'dart:io';

import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/enums.dart';

class UserFormController extends GetxController {
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  final ChildController childController = Get.put(ChildController());
  final selectedGender = Rx<Gender?>(null);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController deathDateController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final Rx<File?> selectedFile = Rx<File?>(null);
  final TextEditingController idController = TextEditingController();
  final lifeStatus = Rx<LifeStatus?>(null);
  final TextEditingController person1Id = TextEditingController();
  final TextEditingController person2Id = TextEditingController();

  void setImage(File file) {
    selectedFile.value = file;
  }

  void updateGender(Gender? gender) {
    selectedGender.value = gender;
  }

  void updateLifeStatus(LifeStatus? life) {
    lifeStatus.value = life;
  }

  String? photoBase64;

  @override
  void onInit() {
    clearForm();
    super.onInit();
  }

  @override
  void onClose() {
    clearForm();
    super.onClose();
  }

  void clearForm() {
    firstNameController.clear();
    secondNameController.clear();
    thirdNameController.clear();
    lastNameController.clear();
    birthDateController.clear();
    deathDateController.clear();
    selectedGender.value = null;
    lifeStatus.value = null;
    selectedFile.value = null;
  }

  addForm() async {
    List<File> files = [];
    if (selectedFile.value != null) {
      files.add(selectedFile.value!);
      List<int> imageBytes = selectedFile.value!.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
    }

    MemberFormModel memberForm = MemberFormModel(
      firstName: firstNameController.text,
      secondName: secondNameController.text,
      thirdName: thirdNameController.text,
      familyId: idController.text,
      gender: selectedGender.value.toString().split('.').last,
      dateOfBirth: DateTime.parse(birthDateController.text),
      //   dateOfDeath: DateTime.parse(deathDateController.text),
      photoBase64: photoBase64,
    );

    var response = await NetworkHandler.postFormRequest(
      AppLink.addMember,
      memberForm.toJson(),
      files: files,
      includeToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      person1Id.text = responseData['id'];
      person2Id.text = responseData['id'];
      marriageFormController.partner1Id.text = responseData['id'];
      marriageFormController.partner2Id.text = responseData['id'];
      childController.childId.text = responseData['id'];

      print("user: $responseData");
      if (Get.arguments == "child") {
        childController.addChild();
        Get.back();
        Get.back();
      } else if (Get.arguments == "spouse") {
        marriageFormController.clearForm();
        Get.toNamed(AppRoute.spouseMarriageStatus);
      } else if (Get.arguments == "parent") {
        Get.toNamed(AppRoute.spouseForm);
      } else {
        Get.toNamed(AppRoute.tree);
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add member. Status code: ${response.statusCode}",
      );
      print(response.body);
    }
  }
}
