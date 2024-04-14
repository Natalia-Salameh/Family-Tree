import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/member_form_controller.dart';
import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
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
    final FamilyNameController familyNameController =
        Get.put(FamilyNameController());

    return GetBuilder<MemberFormController>(
        init: MemberFormController(),
        builder: (memberFormController) {
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
                          const Text(
                            "Lets get started by adding you first, fill these in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Profile(
                            onImagePicked: (file) {
                              memberFormController.setImage(file);
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: CustomTextForm(
                                    hintText: "First name",
                                    myController: memberFormController
                                        .firstNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "required*";
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
                                    hintText: "Second name",
                                    myController: memberFormController
                                        .secondNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "required *";
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
                                    hintText: "Third name",
                                    myController: memberFormController
                                        .thirdNameController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return "required *";
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
                                        familyNameController.lastNameController,
                                    hint: "Family Name",
                                    isFamilyNameSelected: true,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(children: [
                            const Expanded(
                                flex: 0,
                                child: Text(
                                  "Gender: ",
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "Female",
                                    genderValue: Gender.female,
                                    selectedGender: memberFormController
                                        .selectedGender.value,
                                    onGenderSelected: (val) {
                                      memberFormController
                                          .updateGender(Gender.female);
                                    },
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(() => RadioButton(
                                    label: "Male",
                                    genderValue: Gender.male,
                                    selectedGender: memberFormController
                                        .selectedGender.value,
                                    onGenderSelected: (val) {
                                      memberFormController
                                          .updateGender(Gender.male);
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
                                            child: const Text("Done",
                                                style: TextStyle(
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

                                            memberFormController
                                                .birthDateController
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
                                  hintText: "Birthday",
                                  myController:
                                      memberFormController.birthDateController,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Button(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    progressController.updateProgress();
                                    memberFormController.addForm();
                                  }
                                },
                                color: CustomColors.primaryColor,
                                child: const Text(
                                  "Next",
                                  style: TextStyle(color: CustomColors.white),
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
