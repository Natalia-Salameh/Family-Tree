import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
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

class UserForm extends StatelessWidget {
  UserForm({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FamilyNameController familyNameController =
        Get.put(FamilyNameController());
    UserFormController userFormController = Get.put(UserFormController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.myCustomColor,
        title: Get.arguments == "parent"
            ? Text(
                "Add first parent".tr,
                style: TextStyle(color: Colors.white),
              )
            : Text(
                "Add the starting person".tr,
                style: TextStyle(color: Colors.white),
              ),
        centerTitle: true,
        leading: Get.arguments == null
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(result: "false");
                },
              ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  //--------- Profile Image -----------
                  const SizedBox(height: 1),
                  Obx(() => Profile(
                        onImagePicked: (file) {
                          userFormController.setImage(
                              file); // This will store the file in the controller
                        },
                        imageFile: userFormController.selectedFile
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
                                userFormController.firstNameController,
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
                                userFormController.secondNameController,
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
                                userFormController.thirdNameController,
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
                    height: 20,
                  ),
                  //--------- Gender -----------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender", style: const TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Obx(() => RadioButton(
                                  label: "31".tr,
                                  genderValue: Gender.female,
                                  selectedGender:
                                      userFormController.selectedGender.value,
                                  onGenderSelected: (val) {
                                    userFormController
                                        .updateGender(Gender.female);
                                  },
                                )),
                          ),
                          const SizedBox(width: 8), // Adjust width as needed
                          Expanded(
                            flex: 1,
                            child: Obx(() => RadioButton(
                                  label: "32".tr,
                                  genderValue: Gender.male,
                                  selectedGender:
                                      userFormController.selectedGender.value,
                                  onGenderSelected: (val) {
                                    userFormController
                                        .updateGender(Gender.male);
                                  },
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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
                                            color: CustomColors.primaryColor)),
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
                                    userFormController.birthDateController
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
                          myController: userFormController.birthDateController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //--------- Life Status -----------
                  //--------- Life Status -----------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Life Status", style: const TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Obx(() => RadioButton(
                                  label: "Alive".tr,
                                  genderValue: LifeStatus.alive,
                                  selectedGender:
                                      userFormController.lifeStatus.value,
                                  onGenderSelected: (val) {
                                    userFormController
                                        .updateLifeStatus(LifeStatus.alive);
                                  },
                                )),
                          ),
                          const SizedBox(width: 8), // Adjust width as needed
                          Expanded(
                            flex: 1,
                            child: Obx(() => RadioButton(
                                  label: "Dead".tr,
                                  genderValue: LifeStatus.dead,
                                  selectedGender:
                                      userFormController.lifeStatus.value,
                                  onGenderSelected: (val) {
                                    userFormController
                                        .updateLifeStatus(LifeStatus.dead);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //--------- Death Date -----------
                  Obx(() => Visibility(
                        visible: userFormController.lifeStatus.value ==
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
                                          userFormController.deathDateController
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
                                    userFormController.deathDateController,
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
                            userFormController.addForm();
                          }
                        },
                        color: CustomColors.primaryColor,
                        child: Get.arguments == "parent"
                            ? Text(
                                "Next".tr,
                                style:
                                    const TextStyle(color: CustomColors.white),
                              )
                            : Text(
                                "Add".tr,
                                style:
                                    const TextStyle(color: CustomColors.white),
                              )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
