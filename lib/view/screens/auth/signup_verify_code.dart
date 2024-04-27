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
    return Scaffold(
        body: GetBuilder<SendCodeController>(
      builder: (controller) => SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.15),
                    child: Text(
                      "16".tr,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "17".tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: Center(
                          child: Text(
                            "18".tr,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
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
                                color: CustomColors.primaryColor),
                          ),
                        ),
                        margin: EdgeInsets.all(screenHeight * 0.01),
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
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: Center(
                          child: Obx(() => _onEditing.value
                              ? Text("20".tr)
                              : Text(
                                  ' ${"23".tr} ${verifyEmailController.code.value}')),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MaterialButton(
                        onPressed: () {
                          sendCodeController.sendCode();
                        },
                        child: Text("21".tr),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoute.getStarted);
                        },
                        child: Text("22".tr),
                      ),
                      VerifyButton(
                        onTap: () async {
                          await verifyEmailController.verifyEmail();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
