import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/family_name_controller.dart';
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

class ChildForm extends StatelessWidget {
  ChildForm({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FamilyNameController familyNameController =
        Get.put(FamilyNameController());
    final ChildFormController childFormController =
        Get.put(ChildFormController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Child"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                            childFormController.setImage(
                                file); // This will store the file in the controller
                          },
                          imageFile: childFormController.selectedFile
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
                                  childFormController.firstNameController,
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
                                  childFormController.secondNameController,
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
                                  childFormController.thirdNameController,
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
                    // searchPersonController.search(
                    //     "${userFormController.firstNameController.text} ${userFormController.secondNameController.text} ${userFormController.thirdNameController.text} ${familyNameController.lastNameController.text}"),
                    // searchPersonController.fullNameResult.value ==
                    //         "${userFormController.firstNameController.text} ${userFormController.secondNameController.text} ${userFormController.thirdNameController.text}"
                    //     ? Text("This name already exists")
                    //     : Text(""),
                    const SizedBox(
                      height: 40,
                    ),
                    //--------- Gender -----------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gender", style: const TextStyle(fontSize: 16)),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Obx(() => RadioButton(
                                      label: "31".tr,
                                      genderValue: Gender.female,
                                      selectedGender: childFormController
                                          .selectedGender.value,
                                      onGenderSelected: (val) {
                                        childFormController
                                            .updateGender(Gender.female);
                                      },
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Obx(() => RadioButton(
                                      label: "32".tr,
                                      genderValue: Gender.male,
                                      selectedGender: childFormController
                                          .selectedGender.value,
                                      onGenderSelected: (val) {
                                        childFormController
                                            .updateGender(Gender.male);
                                      },
                                    )),
                              ),
                            ]),
                      ],
                    ),
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
                                      childFormController.birthDateController
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
                                childFormController.birthDateController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //--------- Life Status -----------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Life Status",
                            style: const TextStyle(fontSize: 16)),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Obx(() => RadioButton(
                                      label: "Alive".tr,
                                      genderValue: LifeStatus.alive,
                                      selectedGender:
                                          childFormController.lifeStatus.value,
                                      onGenderSelected: (val) {
                                        childFormController
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
                                          childFormController.lifeStatus.value,
                                      onGenderSelected: (val) {
                                        childFormController
                                            .updateLifeStatus(LifeStatus.dead);
                                      },
                                    )),
                              ),
                            ]),
                      ],
                    ),
                    //--------- Death Date -----------
                    Obx(() => Visibility(
                          visible: childFormController.lifeStatus.value ==
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
                                            childFormController
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
                                      childFormController.deathDateController,
                                ),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      child: Button(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              childFormController.addForm();
                            }
                          },
                          color: CustomColors.primaryColor,
                          child: Get.arguments == "parent"
                              ? Text(
                                  "Next".tr,
                                  style: const TextStyle(
                                      color: CustomColors.white),
                                )
                              : Text(
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
  }
}
