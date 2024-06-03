import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpouseMarriageStatus extends StatelessWidget {
  SpouseMarriageStatus({super.key});
  final formKey = GlobalKey<FormState>();
  final ChildController childController = Get.put(ChildController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarriageFormController>(
        init: MarriageFormController(),
        builder: (marriageFormController) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Marriage Status
                        Text(
                          "Marriage Status".tr,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Status".tr,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Obx(() => RadioButton(
                                  label: "Married".tr,
                                  genderValue: MarriageStatus.married,
                                  selectedGender: marriageFormController
                                      .marriageStatus.value,
                                  onGenderSelected: (val) {
                                    marriageFormController
                                        .updateMarriage(MarriageStatus.married);
                                  },
                                )),
                            Obx(() => RadioButton(
                                  label: "Divorced".tr,
                                  genderValue: MarriageStatus.divorced,
                                  selectedGender: marriageFormController
                                      .marriageStatus.value,
                                  onGenderSelected: (val) {
                                    marriageFormController.updateMarriage(
                                        MarriageStatus.divorced);
                                  },
                                )),
                            Obx(() => RadioButton(
                                  label: "Widowed".tr,
                                  genderValue: MarriageStatus.widowed,
                                  selectedGender: marriageFormController
                                      .marriageStatus.value,
                                  onGenderSelected: (val) {
                                    marriageFormController
                                        .updateMarriage(MarriageStatus.widowed);
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Date of Marriage
                        Text(
                          "Marriage Date".tr,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CupertinoButton(
                                          child: Text("Done".tr,
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
                                              "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                                          marriageFormController.dateOfMarriage
                                              .text = dateTimeText;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: AbsorbPointer(
                            child: CustomTextForm(
                              hintText: "Select Date".tr,
                              myController:
                                  marriageFormController.dateOfMarriage,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Add Button
                        SizedBox(
                          height: 50,
                          child: Button(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  marriageFormController.addMarriage();
                                }
                              },
                              color: CustomColors.primaryColor,
                              child: Text(
                                "Add".tr,
                                style: const TextStyle(
                                    color: CustomColors.white, fontSize: 18),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
