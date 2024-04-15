import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class MemberLegacyController extends GetxController {
  static MemberLegacyController get to => Get.find();
  String education = '';
  String work = '';
  String legacyStory = '';
  String firstName = '';
  String secondName = '';
  String thirdName = '';
  Family family = Family(id: '', familyName: '');
  String gender = '';
  DateTime dateOfBirth = DateTime.now();
  String photoBase64 = '';

  @override
  void onInit() {
    super.onInit();
    LegacyInfo();
  }

  LegacyInfo() async {
    var response = await NetworkHandler.getRequest(
      AppLink.memberLegacy,
      includeToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      LegacyModel legacyInfoModel = accountInfoModelFromJson(response.body);
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
