import 'dart:convert';
import 'dart:typed_data';

import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/get_child_and_spouse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildSpouseController extends GetxController {
  final TextEditingController personIdController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  Uint8List? getImageBytes(String base64String) {
    if (base64String.isNotEmpty) {
      return base64Decode(base64String);
    }
    return null;
  }

  Future<List<GetSpouseAndChildrenModel>> fetchSpouseAndChildrenById(
      String memberId) async {
    var response = await NetworkHandler.getRequest(
      AppLink.getChildSpouse,
      includeToken: true,
      queryParams: {'memberId': memberId},
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getSpouseAndChildrenModelFromJson(response.body);
    } else {
      print(
          'Failed to fetch data for memberId $memberId: ${response.statusCode}');
      print('Error details: ${response.body}');
      return [];
    }
  }
}
