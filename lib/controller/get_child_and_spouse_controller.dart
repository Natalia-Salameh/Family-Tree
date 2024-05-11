import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/get_child_and_spouse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildSpouseController extends GetxController {
  final TextEditingController personIdController = TextEditingController();
  String education = '';

  @override
  void onInit() {
    super.onInit();
  }

  fetchSpouseAndChildren() async {
    //print(personIdController.text);
    var response = await NetworkHandler.getRequest(
      AppLink.getChildSpouse,
      includeToken: true,
      queryParams: {'memberId': personIdController.text},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<GetSpouseAndChildrenModel> getSpouseChildModel =
          getSpouseAndChildrenModelFromJson(response.body);

      // GetSpouseAndChildrenModel childSpouseInfoModel = GetSpouseAndChildrenModel(marriageId: '', spouse: null, marriageStatus: '', children: []);
      //  education = childSpouseInfoModel.;

      print(response.body);
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
