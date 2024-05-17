import 'package:family_tree_application/controller/send_email_controller.dart';
import 'package:family_tree_application/controller/verify_email_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import '../../widgets/verify_button.dart';

class VerifyCode extends StatelessWidget {
  final _onEditing = true.obs;

  final SendCodeController sendCodeController = Get.put(SendCodeController());
  final VerifyEmailController verifyEmailController =
      Get.put(VerifyEmailController());

  VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03, horizontal: screenWidth * 0.1),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "16".tr,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "17".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Text(
                  "18".tr,
                  style: const TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                VerificationCode(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                  keyboardType: TextInputType.number,
                  underlineColor: CustomColors.primaryColor,
                  length: 6,
                  cursorColor: CustomColors.primaryColor,
                  clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "19".tr,
                      style: const TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                  ),
                  onCompleted: (String value) {
                    verifyEmailController.code.value = value;
                  },
                  onEditing: (bool value) {
                    _onEditing.value = value;
                    if (!_onEditing.value) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  digitsOnly: true,
                ),
                Obx(
                  () => _onEditing.value
                      ? Text(
                          "20".tr,
                        )
                      : Text(
                          '${"23".tr} ${verifyEmailController.code.value}',
                        ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    sendCodeController.sendCode();
                  },
                  child: Text("21".tr),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.getStarted);
                  },
                  child: Text("22".tr),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: VerifyButton(
                    onTap: () async {
                      await verifyEmailController.verifyEmail();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
