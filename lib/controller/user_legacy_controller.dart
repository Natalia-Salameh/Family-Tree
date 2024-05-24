import 'dart:convert';
import 'dart:typed_data';

import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/model/user_legacy_model.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class UserLegacyController extends GetxController {
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  String education = '';
  String work = '';
  String legacyStory = '';
  String firstName = '';
  String secondName = '';
  String thirdName = '';
  Family family = Family(id: '', familyName: '');
  String gender = '';
  dynamic dateOfBirth = '';
  String photoBase64 = '';
  String userId = '';
  Uint8List? imageBytes;
  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments['id'];
    print("User ID received in UserLegacyPage: $userId");

    legacyInfo();
  }

  legacyInfo() async {
    print(userId);
    var response = await NetworkHandler.getRequest(
      AppLink.userLegacy,
      includeToken: true,
      queryParams: {'memberId': userId},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserLegacyModel legacyInfoModel = userLegacyModelFromJson(response.body);
      education = legacyInfoModel.education;
      work = legacyInfoModel.work;
      legacyStory = legacyInfoModel.legacyStory;
      firstName = legacyInfoModel.firstName;
      secondName = legacyInfoModel.secondName;
      thirdName = legacyInfoModel.thirdName;
      family = legacyInfoModel.family;
      gender = legacyInfoModel.gender;
      dateOfBirth = legacyInfoModel.dateOfBirth;
      childSpouseController.personIdController.text = legacyInfoModel.memberId;
      if (legacyInfoModel.photoBase64 != null &&
          legacyInfoModel.photoBase64.isNotEmpty) {
        imageBytes = base64Decode(legacyInfoModel.photoBase64);
      }
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
