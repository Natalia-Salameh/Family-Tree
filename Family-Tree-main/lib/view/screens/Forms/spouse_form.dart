import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpouseForm extends StatelessWidget {
  SpouseForm({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FamilyNameController familyNameController =
        Get.put(FamilyNameController());
    SpouseFormController spouseFormController = Get.put(SpouseFormController());

    return Scaffold(
      appBar: AppBar(
        title: Get.arguments == "parent"
            ? Text(
                "Add second parent".tr,
                style: TextStyle(color: Colors.white),
              )
            : Text(
                "Add spouse".tr,
                style: TextStyle(color: Colors.white),
              ),
        centerTitle: true,
        leading: Get.arguments == "parent"
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.back(result: "false");
                },
              ),
      ),
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
                    //--------- Profile Image -----------
                    const SizedBox(height: 20),
                    Obx(() => Profile(
                          onImagePicked: (file) {
                            spouseFormController.setImage(
                                file); // This will store the file in the controller
                          },
                          imageFile: spouseFormController.selectedFile
                              .value, // Ensure this is displayed correctly
                        )),
                    //--------- Full Name -----------
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: CustomTextForm(
                              hintText: "55".tr,
                              myController:
                                  spouseFormController.firstNameController,
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
                                  spouseFormController.secondNameController,
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
                                  spouseFormController.thirdNameController,
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
                                  familyNameController.lastNameController,
                              hint: "29".tr,
                              isFamilyNameSelected: true,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //--------- Gender -----------
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
                                  spouseFormController.selectedGender.value,
                              onGenderSelected: (val) {
                                spouseFormController
                                    .updateGender(Gender.female);
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => RadioButton(
                              label: "32".tr,
                              genderValue: Gender.male,
                              selectedGender:
                                  spouseFormController.selectedGender.value,
                              onGenderSelected: (val) {
                                spouseFormController.updateGender(Gender.male);
                              },
                            )),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    //--------- Birth Date -----------
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      child: Text("33".tr,
                                          style: const TextStyle(
                                              color:
                                                  CustomColors.primaryColor)),
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
                                      spouseFormController.birthDateController
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
                            hintText: "34".tr,
                            myController:
                                spouseFormController.birthDateController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //--------- Life Status -----------
                    Row(children: [
                      Expanded(
                          flex: 0,
                          child: Text(
                            "Life Status".tr,
                            style: const TextStyle(fontSize: 16),
                          )),
                      Expanded(
                        flex: 1,
                        child: Obx(() => RadioButton(
                              label: "Alive".tr,
                              genderValue: LifeStatus.alive,
                              selectedGender:
                                  spouseFormController.lifeStatus.value,
                              onGenderSelected: (val) {
                                spouseFormController
                                    .updateLifeStatus(LifeStatus.alive);
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => RadioButton(
                              label: "Dead".tr,
                              genderValue: LifeStatus.dead,
                              selectedGender:
                                  spouseFormController.lifeStatus.value,
                              onGenderSelected: (val) {
                                spouseFormController
                                    .updateLifeStatus(LifeStatus.dead);
                              },
                            )),
                      ),
                    ]),
                    //--------- Death Date -----------
                    Obx(() => Visibility(
                          visible: spouseFormController.lifeStatus.value ==
                              LifeStatus.dead,
                          child: GestureDetector(
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
                                            spouseFormController
                                                .deathDateController
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
                                  hintText: "Death Date".tr,
                                  myController:
                                      spouseFormController.deathDateController,
                                ),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Button(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              spouseFormController.addSpouse();
                            }
                          },
                          color: CustomColors.primaryColor,
                          child: Text(
                            "Next".tr,
                            style: const TextStyle(color: CustomColors.white),
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
  }
}
