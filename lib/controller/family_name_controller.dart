import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/model/family_name_model.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

class FamilyNameController extends GetxController {
  final TextEditingController lastNameController = TextEditingController();
  
  var familyNames = <SelectedListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFamilyNames();
  }

  fetchFamilyNames() async {
    var response = await NetworkHandler.getRequest(
      AppLink.familyName,
      includeToken: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<FamilyNameModel> searchModel =
          familyNameModelFromJson(response.body);
      familyNames.value = searchModel
          .map((model) =>
              SelectedListItem(value: model.id, name: model.failyName))
          .toList();
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
