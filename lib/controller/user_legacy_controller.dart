import 'package:family_tree_application/model/user_legacy_model.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class UserLegacyController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments['id'];
    legacyInfo();
  }

  legacyInfo() async {
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

      print(response.body);
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
