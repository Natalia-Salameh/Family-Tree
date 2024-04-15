import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:family_tree_application/model/update_legacy_model.dart';
import 'package:get/get.dart';

class UpdateLegacyController extends GetxController {
  // Fields from MemberLegacyController
  var education = ''.obs;
  var work = ''.obs;
  var legacyStory = ''.obs;
  var firstName = ''.obs;
  var secondName = ''.obs;
  var thirdName = ''.obs;
  var family = Family(id: '', familyName: '').obs;
  var gender = ''.obs;
  var dateOfBirth = DateTime.now().obs;
  var photoBase64 = ''.obs;

  // Method to load initial data into the controller
  void loadInitialData(MemberLegacyController data) {
    education.value = data.education;
    work.value = data.work;
    legacyStory.value = data.legacyStory;
    firstName.value = data.firstName;
    secondName.value = data.secondName;
    thirdName.value = data.thirdName;
    family.value = data.family;
    gender.value = data.gender;
    dateOfBirth.value = data.dateOfBirth;
    photoBase64.value = data.photoBase64;
  }

  void updateLegacyInfo() async {
    var payload = {
      'education': education.value,
      'work': work.value,
      'legacyStory': legacyStory.value,
      'firstName': firstName.value,
      'secondName': secondName.value,
      'thirdName': thirdName.value,
      'family': {'id': family.value.id, 'familyName': family.value.familyName},
      'gender': gender.value,
      'dateOfBirth': dateOfBirth.value.toIso8601String(),
      'photoBase64': photoBase64.value,
    };

    print("Sending payload: $payload"); // Log the payload

    var response = await NetworkHandler.postRequest(
      AppLink.updateMemberLegacy,
      payload,
      includeToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back(); // Success: Close the screen or refresh data
    } else {
      print('Failed to update legacy info: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
