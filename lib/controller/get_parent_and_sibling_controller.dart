import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/get_parent_spouse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:convert';

class ParentSiblingController extends GetxController {
  final TextEditingController personIdController = TextEditingController();
  Uint8List? getImageBytes(String base64String) {
    if (base64String.isNotEmpty) {
      return base64Decode(base64String);
    }
    return null;
  }

  Future<List<GetParentAndSiblingModel>> fetchParentAndSibling(
      String memberId) async {
    var response = await NetworkHandler.getRequest(
      AppLink.getParentSibling,
      includeToken: true,
      queryParams: {'memberId': personIdController.text},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Parent and Sibling: ${response.body}');
      return getParentAndSiblingModelFromJson(response.body);
    } else {
      print('${response.statusCode}');
      print('Error details: ${response.body}');
      return [];
    }
  }
}
