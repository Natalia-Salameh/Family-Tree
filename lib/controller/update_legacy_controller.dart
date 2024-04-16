import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:family_tree_application/model/update_legacy_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  var selectedFamilyId = ''.obs;
  void setSelectedFamily(String id) {
    selectedFamilyId.value = id;
  }

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
    // Update the selectedFamilyId with the ID from the family data
    selectedFamilyId.value = data.family.id;
  }

  Map<String, dynamic> createUpdatePayload() {
    return {
      'education': education.value,
      'work': work.value,
      'legacyStory': legacyStory.value,
      'firstName': firstName.value,
      'secondName': secondName.value,
      'thirdName': thirdName.value,
      'familyId':
          selectedFamilyId.value, 
      'gender': gender.value,
      'dateOfBirth': dateOfBirth.value.toIso8601String(),
      'photoBase64': photoBase64.value,
    };
  }

  void updateLegacyInfo() async {
   
    var payload = {
      "Education": education.value,
      "Work": work.value,
      "LegacyStory": legacyStory.value,
      "FirstName": firstName.value,
      "SecondName": secondName.value,
      "ThirdName": thirdName.value,
      "FamilyId": selectedFamilyId.value, 
      "Gender": gender.value,
      "DateOfBirth": DateFormat('yyyy-MM-dd').format(
          dateOfBirth.value),
      "DateOfDeath": null 
    };

    print("Sending payload: $payload"); 

    try {
      var response = await NetworkHandler.postRequest(
        AppLink.updateMemberLegacy,
        payload,
        includeToken: true,
      );

      // Step 3: Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Update completed successfully!',
            snackPosition: SnackPosition.BOTTOM);
        Get.back(); 
      } else {
        Get.snackbar('Error',
            'Failed to update: ${response.statusCode} ${response.body}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(
          'Error sending update: $e');
      Get.snackbar('Error', 'Network error or invalid response',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
