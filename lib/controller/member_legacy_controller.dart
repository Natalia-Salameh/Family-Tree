import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/model/member_legacy_model.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class MemberLegacyController extends GetxController {
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  static MemberLegacyController get to => Get.find();
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

  @override
  void onInit() {
    super.onInit();
    legacyInfo();
  }

  legacyInfo() async {
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
      childSpouseController.personIdController.text = legacyInfoModel.memberId;
    } else {
      print('Failed to fetch family names: ${response.statusCode}');
      print('Error details: ${response.body}');
    }
  }
}
