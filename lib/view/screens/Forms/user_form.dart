import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/core/constants/colors.dart';

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
        title: Get.arguments == "parent"
            ? Text("Add first person".tr)
            : Text("User Form"),
        centerTitle: true,
        leading: Get.arguments == null
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Obx(() => Profile(
                      onImagePicked: (file) {
                        userFormController.setImage(file);
                      },
                      imageFile: userFormController.selectedFile.value,
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextForm(
                      hintText: "First Name".tr,
                      myController: userFormController.firstNameController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "Please enter first name".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextForm(
                      hintText: "Second Name".tr,
                      myController: userFormController.secondNameController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "Please enter second name".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextForm(
                      hintText: "Third Name".tr,
                      myController: userFormController.thirdNameController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "Please enter third name".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FamilyNameDropDown(
                textEditingController: familyNameController.lastNameController,
                hint: "Family Name".tr,
                isFamilyNameSelected: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Gender ".tr,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => RadioButton(
                          label: "Female".tr,
                          genderValue: Gender.female,
                          selectedGender:
                              userFormController.selectedGender.value,
                          onGenderSelected: (val) {
                            userFormController.updateGender(Gender.female);
                          },
                        )),
                  ),
                  Expanded(
                    child: Obx(() => RadioButton(
                          label: "Male".tr,
                          genderValue: Gender.male,
                          selectedGender:
                              userFormController.selectedGender.value,
                          onGenderSelected: (val) {
                            userFormController.updateGender(Gender.male);
                          },
                        )),
                  ),
                ],
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CupertinoButton(
                                child: Text("Done".tr,
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
                                userFormController.birthDateController.text =
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
                  child: CustomTextForm(
                    hintText: "Birth Date".tr,
                    myController: userFormController.birthDateController,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Life Status".tr,
                    style: const TextStyle(fontSize: 16)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => RadioButton(
                          label: "Alive".tr,
                          genderValue: LifeStatus.alive,
                          selectedGender: userFormController.lifeStatus.value,
                          onGenderSelected: (val) {
                            userFormController
                                .updateLifeStatus(LifeStatus.alive);
                          },
                        )),
                  ),
                  Expanded(
                    child: Obx(() => RadioButton(
                          label: "Deceased".tr,
                          genderValue: LifeStatus.dead,
                          selectedGender: userFormController.lifeStatus.value,
                          onGenderSelected: (val) {
                            userFormController
                                .updateLifeStatus(LifeStatus.dead);
                          },
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() => Visibility(
                    visible:
                        userFormController.lifeStatus.value == LifeStatus.dead,
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      child: Text("Done".tr,
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
                        child: CustomTextForm(
                          hintText: "Death Date".tr,
                          myController: userFormController.deathDateController,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Center(
                child: Button(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      userFormController.addForm();
                    }
                  },
                  color: CustomColors.primaryColor,
                  child: Get.arguments == "parent"
                      ? Text("Next".tr,
                          style: const TextStyle(color: CustomColors.white))
                      : Text("Add".tr,
                          style: const TextStyle(color: CustomColors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
