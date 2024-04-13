import 'package:family_tree_application/controller/member_form_controller.dart';
import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberForm extends StatelessWidget {
  MemberForm({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();
    return GetBuilder<MemberFormController>(
        init: MemberFormController(),
        builder: (controller) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ProgressBar(
                            progress: progressController.progress.value,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "54".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Profile(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: CustomTextForm(
                                    hintText: "55".tr,
                                    myController:
                                        controller.firstNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "52".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: CustomTextForm(
                                    hintText: "56".tr,
                                    myController:
                                        controller.secondNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "52".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: CustomTextForm(
                                    hintText: "57".tr,
                                    myController:
                                        controller.thirdNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "52".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: FamilyNameDropDown(
                                  textEditingController:
                                      controller.lastNameController,
                                  hint: "29".tr,
                                  isFamilyNameSelected: true,
                                  familyNames: MockData.familyName,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(children: [
                            Expanded(
                                flex: 0,
                                child: Text(
                                  "30".tr,
                                  style: const TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "31".tr,
                                    genderValue: Gender.female,
                                    selectedGender:
                                        controller.selectedGender.value,
                                    onGenderSelected: (val) {
                                      controller.updateGender(Gender.female);
                                    },
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "32".tr,
                                    genderValue: Gender.male,
                                    selectedGender:
                                        controller.selectedGender.value,
                                    onGenderSelected: (val) {
                                      controller.updateGender(Gender.male);
                                    },
                                  )),
                            ),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  height: 300,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CupertinoButton(
                                            child: Text("33".tr,
                                                style: const TextStyle(
                                                    color: CustomColors
                                                        .primaryColor)),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (DateTime value) {
                                            final dateTimeText =
                                                "${value.year}-${value.month}-${value.day}";
                                            controller.dateController.text =
                                                dateTimeText;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: AbsorbPointer(
                              child: SizedBox(
                                child: CustomTextForm(
                                  hintText: "34".tr,
                                  myController: controller.dateController,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: Button(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    progressController.updateProgress();
                                    Get.offAllNamed(AppRoute.treeForm);
                                  }
                                },
                                color: CustomColors.primaryColor,
                                child: Text(
                                  "58".tr,
                                  style: const TextStyle(
                                      color: CustomColors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
