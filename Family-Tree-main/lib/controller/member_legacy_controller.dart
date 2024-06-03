import 'dart:convert';
import 'dart:typed_data';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/get_parent_and_sibling_controller.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class MemberLegacyController extends GetxController {
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  final ParentSiblingController parentChildController =
      Get.put(ParentSiblingController());
  static MemberLegacyController get to => Get.find();

  var location = ''.obs;
  var work = ''.obs;
  var legacyStory = ''.obs;
  var firstName = ''.obs;
  var secondName = ''.obs;
  var thirdName = ''.obs;
  var family = Family(id: '', familyName: '').obs;
  var gender = ''.obs;
  var dateOfBirth = ''.obs;
  var photoBase64 = ''.obs;
  Uint8List? imageBytes;
  var decision = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    legacyInfo();
  }

  Future<void> legacyInfo() async {
    isLoading.value = true;
    var response = await NetworkHandler.getRequest(
      AppLink.memberLegacy,
      includeToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      LegacyModel legacyInfoModel = accountInfoModelFromJson(response.body);
      location.value = legacyInfoModel.location;
      work.value = legacyInfoModel.work;
      legacyStory.value = legacyInfoModel.legacyStory;
      firstName.value = legacyInfoModel.firstName;
      secondName.value = legacyInfoModel.secondName;
      thirdName.value = legacyInfoModel.thirdName;
      family.value = legacyInfoModel.family;
      gender.value = legacyInfoModel.gender;
      dateOfBirth.value = legacyInfoModel.dateOfBirth;
      childSpouseController.personIdController.text = legacyInfoModel.memberId;
      parentChildController.personIdController.text = legacyInfoModel.memberId;
      decision.value = legacyInfoModel.decision;
      if (legacyInfoModel.photoBase64 != null &&
          legacyInfoModel.photoBase64.isNotEmpty) {
        imageBytes = base64Decode(legacyInfoModel.photoBase64);
      }
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
    isLoading.value = false;
  }
}
