import 'dart:convert';
import 'dart:io';

import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/enums.dart';

class MemberFormController extends GetxController {
  final selectedGender = Rx<Gender?>(null);
  final selectedMarriage = Rx<MarriageStatus?>(null);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController deathDateController = TextEditingController();
  // final TextEditingController memberId = TextEditingController();
  final TextEditingController person1Id = TextEditingController();
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  final FamilyNameController familyNameController =
      Get.put(FamilyNameController());

  var family = '';
  var gender = '';

  final Rx<File?> selectedFile = Rx<File?>(null);
  final TextEditingController idController = TextEditingController();
  final lifeStatus = Rx<LifeStatus?>(null);
  void setImage(File file) {
    selectedFile.value = file;
    print('Image file selected: ${file.path}');
  }

  void updateGender(Gender? gender) {
    selectedGender.value = gender;
  }

  void updateMarriage(MarriageStatus? marriage) {
    selectedMarriage.value = marriage;
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
    birthDateController.clear();
    deathDateController.clear();
    idController.clear();
    selectedGender.value = null;
    lifeStatus.value = null;
    selectedFile.value = null;
    familyNameController.clearLastName();
    print("Clearing form controllers and state");
  }

  addForm() async {
    List<File> files = [];
    if (selectedFile.value != null) {
      files.add(selectedFile.value!);
    }

    MemberFormModel memberForm = MemberFormModel(
      firstName: firstNameController.text,
      secondName: secondNameController.text,
      thirdName: thirdNameController.text,
      familyId: idController.text,
      gender: selectedGender.value.toString().split('.').last,
      dateOfBirth: DateTime.parse(birthDateController.text),
      // dateOfDeath: DateTime.parse(deathDateController.text),
    );

    var response = await NetworkHandler.postFormRequest(
      AppLink.addMember,
      memberForm.toJson(),
      includeToken: true,
      imageFile: selectedFile.value,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      //   memberId.text = responseData['id'];
      family = responseData['family']['familyName'];
      gender = responseData['gender'];

      var connectMember = await NetworkHandler.postParamsRequest(
        AppLink.connectMemberWithAccount,
        queryParams: {'memberId': responseData['id']},
        includeToken: true,
      );

      if (connectMember.statusCode == 200 || connectMember.statusCode == 201) {
        person1Id.text = responseData['id'];

        marriageFormController.selectedNodeIdPerson1.text = responseData['id'];
        if (Get.arguments == "parent") {
          Get.toNamed(AppRoute.spouseForm);
        } else {
          Get.toNamed(AppRoute.treeForm);
        }
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "user is already connected to a member. Status code: ${connectMember.statusCode}",
        );
        print(connectMember.body);
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
