import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:family_tree_application/model/update_legacy_model.dart';
import 'package:get/get.dart';

class UpdateLegacyController extends GetxController {
  var family = Family(id: '', familyName: '').obs;
  var selectedFamilyId = ''.obs;
  var location = ''.obs;
  var work = ''.obs;
  var legacyStory = ''.obs;
  var firstName = ''.obs;
  var secondName = ''.obs;
  var thirdName = ''.obs;
  var gender = ''.obs;
  var dateOfBirth = DateTime.now().obs;

  void setSelectedFamily(String id, String familyName) {
    selectedFamilyId.value = id;
    family.update((val) {
      val?.id = id;
      val?.familyName = familyName;
    });
  }

  void loadInitialData(MemberLegacyController data) {
    location.value = data.location.value;
    work.value = data.work.value;
    legacyStory.value = data.legacyStory.value;
    firstName.value = data.firstName.value;
    secondName.value = data.secondName.value;
    thirdName.value = data.thirdName.value;
    family.value = data.family.value;
    selectedFamilyId.value = data.family.value.id;
    gender.value = data.gender.value;

    // Ensure dateOfBirth is parsed as DateTime
    if (data.dateOfBirth.value is String) {
      dateOfBirth.value = DateTime.parse(data.dateOfBirth.value as String);
    } else {
      dateOfBirth.value = data.dateOfBirth.value as DateTime;
    }
  }

  void updateLegacyInfo() async {
    var payload = {
      'location': location.value,
      'work': work.value,
      'legacyStory': legacyStory.value,
      'firstName': firstName.value,
      'secondName': secondName.value,
      'thirdName': thirdName.value,
      'familyId': selectedFamilyId.value,
      'familyName': family.value.familyName,
      'gender': gender.value,
      'dateOfBirth': dateOfBirth.value.toIso8601String(),
    };

    var response = await NetworkHandler.postRequest(
      AppLink.updateMemberLegacy,
      payload,
      includeToken: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back(result: 'updateSuccessful');
      Get.snackbar('Success', 'Update completed successfully!');
    } else {
      Get.snackbar('Error', 'Failed to update: ${response.body}');
      print('Failed to update legacy info: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}

// var selectedFamilyId = ''.obs;
// void setSelectedFamily(String id) {
//   selectedFamilyId.value = id;
// }
//selectedFamilyId.value = data.family.id;