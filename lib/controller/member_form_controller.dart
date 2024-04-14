import 'dart:convert';
import 'dart:io';

import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/enums.dart';

class MemberFormController extends GetxController {
  final selectedGender = Rx<Gender?>(null);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final Rx<File?> selectedFile = Rx<File?>(null);
  final TextEditingController idController = TextEditingController();

  void setImage(File file) {
    selectedFile.value = file;
  }

  void updateGender(Gender? gender) {
    selectedGender.value = gender;
  }

  List<File> files = [];
  String? photoBase64;

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
      photoBase64: photoBase64,
    );

    print(memberForm.toJson());
    var response = await NetworkHandler.postFormRequest(
      AppLink.addMember,
      memberForm.toJson(),
      files: files,
      includeToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      Get.toNamed(AppRoute.treeForm);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add member. Status code: ${response.statusCode}",
      );
      print(response.body);
    }
  }
}
