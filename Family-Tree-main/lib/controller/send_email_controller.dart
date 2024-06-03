import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/send_email_model.dart';
import 'package:get/get.dart';

class SendCodeController extends GetxController {
  String? email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    sendCode();
  }

  sendCode() async {
    if (email != null) {
      SendEmailModel sendEmailData = SendEmailModel(email: email!);
      var response = await NetworkHandler.postRequest(
        AppLink.sendEmailVerification,
        sendEmailData.toJson(),
      );
      print(response.body);
    } else {
      print('Email is null');
    }
  }
}
