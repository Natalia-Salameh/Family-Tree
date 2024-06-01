import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/get_parent_spouse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:convert';

class ParentSiblingController extends GetxController {
  final TextEditingController personIdController = TextEditingController();

  var parent1firstName = '';
  var parent1lastName = '';
  var parent1Gender = '';
  var parent1Image = '';
  var parent1Decision = '';
  var parent1MemberId = '';
  var parent2firstName = '';
  var parent2lastName = '';
  var parent2Gender = '';
  var parent2Image = '';
  var parent2Decision = '';
  var parent2MemberId = '';
  var siblings = [];
  var marriageId = '';

  Uint8List? getImageBytes(String base64String) {
    if (base64String.isNotEmpty) {
      return base64Decode(base64String);
    }
    return null;
  }

  fetchParentAndSibling(String memberId) async {
    var response = await NetworkHandler.getRequest(
      AppLink.getParentSibling,
      includeToken: true,
      queryParams: {'memberId': personIdController.text},
    );

    if (response.body == 'no parent') {
      // Handle the case where there is no parent
      parent1firstName = '';
      parent1lastName = '';
      parent1Gender = '';
      parent1Image = '';
      parent1Decision = '';
      parent1MemberId = '';
      parent2firstName = '';
      parent2lastName = '';
      parent2Gender = '';
      parent2Image = '';
      parent2Decision = '';
      parent2MemberId = '';
      siblings = [];
      marriageId = '';
      return;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      GetParentAndSiblingModel parentAndSibling =
          getParentAndSiblingModelFromJson(response.body);

      parent1firstName = parentAndSibling.parent1?.firstName ?? '';
      parent1lastName = parentAndSibling.parent1?.familyName ?? '';
      parent1Gender = parentAndSibling.parent1?.gender ?? '';
      parent1Image = parentAndSibling.parent1?.memberPhoto ?? '';
      parent1Decision = parentAndSibling.parent1?.decision ?? '';
      parent1MemberId = parentAndSibling.parent1?.memberId ?? '';

      parent2firstName = parentAndSibling.parent2?.firstName ?? '';
      parent2lastName = parentAndSibling.parent2?.familyName ?? '';
      parent2Gender = parentAndSibling.parent2?.gender ?? '';
      parent2Image = parentAndSibling.parent2?.memberPhoto ?? '';
      parent2Decision = parentAndSibling.parent2?.decision ?? '';
      parent2MemberId = parentAndSibling.parent2?.memberId ?? '';

      siblings = parentAndSibling.siblings ?? [];
      marriageId = parentAndSibling.marriageId ?? '';
    } else {
      print('${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
