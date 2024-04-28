import 'dart:convert';

import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/model/marriage_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarriageFormController extends GetxController {
  final ChildController childController = Get.put(ChildController());
  final TextEditingController partner1Id = TextEditingController();
  final TextEditingController partner2Id = TextEditingController();
  final marriageStatus = Rx<MarriageStatus?>(null);
  final TextEditingController dateOfMarriage = TextEditingController();
  final TextEditingController marriageId = TextEditingController();

  void clearForm() {
    marriageStatus.value = null;
    dateOfMarriage.clear();
  }

  void updateMarriage(MarriageStatus? marriage) {
    marriageStatus.value = marriage;
  }

  addMarriage() async {
    AddMarriageModel addMarriageModel = AddMarriageModel(
      partner1Id: partner1Id.text,
      partner2Id: partner2Id.text,
      marriageStatus: marriageStatus.value.toString().split('.').last,
      dateOfMarriage: DateTime.parse(dateOfMarriage.text),
    );
    var response = await NetworkHandler.postRequest(
      AppLink.addMarriageForm,
      addMarriageModel.toJson(),
      includeToken: true,
    );
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      marriageId.text = responseData['marriageRelationid'];
      childController.marriageId.text = responseData['marriageRelationid'];
      Get.back();
      Get.back();
      Get.back();
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add member. Status code: ${response.statusCode}",
      );
      print(response.body);
    }
  }
}
