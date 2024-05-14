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
            // appBar: AppBar(),
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
                          //--------- Marriage status -----------
                          Row(children: [
                            Expanded(
                                flex: 0,
                                child: Text(
                                  "Add".tr,
                                  style: const TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "Married".tr,
                                    genderValue: MarriageStatus.married,
                                    selectedGender: marriageFormController
                                        .marriageStatus.value,
                                    onGenderSelected: (val) {
                                      marriageFormController.updateMarriage(
                                          MarriageStatus.married);
                                    },
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "Divorced".tr,
                                    genderValue: MarriageStatus.divorced,
                                    selectedGender: marriageFormController
                                        .marriageStatus.value,
                                    onGenderSelected: (val) {
                                      marriageFormController.updateMarriage(
                                          MarriageStatus.divorced);
                                    },
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "Widowed".tr,
                                    genderValue: MarriageStatus.widowed,
                                    selectedGender: marriageFormController
                                        .marriageStatus.value,
                                    onGenderSelected: (val) {
                                      marriageFormController.updateMarriage(
                                          MarriageStatus.widowed);
                                    },
                                  )),
                            ),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          //--------- Date of Marriage -----------
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
                                                "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                                            marriageFormController
                                                .dateOfMarriage
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
                              child: SizedBox(
                                child: CustomTextForm(
                                  hintText: "Marriage Date".tr,
                                  myController:
                                      marriageFormController.dateOfMarriage,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
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
