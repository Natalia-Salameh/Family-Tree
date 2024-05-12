import 'dart:convert';

import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/add_child_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ParentController extends GetxController {
  final TextEditingController childId = TextEditingController();
  final TextEditingController marriageId = TextEditingController();
  //final TextEditingController parentChildRelationId = TextEditingController();

  addParent() async {
    AddChildModel addChildModel = AddChildModel(
      childId: childId.text,
      marriageId: marriageId.text,
    );

    print("childd childController.childId.text ${childId.text} ,marriage ${marriageId.text}");

    var response = await NetworkHandler.postRequest(
      AppLink.addChild,
      addChildModel.toJson(),
      includeToken: true,
    );
    var responseData = jsonDecode(response.body);
    print("child id ${childId.text} marriage id ${marriageId.text}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //parentChildRelationId.text = responseData['parentChildRelationid'];
      print("child: $responseData");
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add member. Status code: ${response.statusCode}",
      );
      print(response.body);
    }
  }
}
