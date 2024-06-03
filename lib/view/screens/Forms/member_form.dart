import 'package:family_tree_application/classes/showPopOut_addM.dart';
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
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MemberForm extends StatefulWidget {
  MemberForm({super.key});

  @override
  State<MemberForm> createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupContentTree();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopup(context);
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();
    final FamilyNameController familyNameController =
        Get.put(FamilyNameController());
    MemberFormController memberFormController = Get.put(MemberFormController());

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
                    Profile(
                      onImagePicked: (file) {
                        memberFormController.setImage(
                            file); // This will store the file in the controller
                      },
                      imageFile: memberFormController.selectedFile
                          .value, // Ensure this is displayed correctly
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: CustomTextForm(
                              hintText: "55".tr,
                              myController:
                                  memberFormController.firstNameController,
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
                                  memberFormController.secondNameController,
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
                                  memberFormController.thirdNameController,
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
                                      label: "32".tr,
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
                      ],
                    ),
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

                                      memberFormController.birthDateController
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
                                memberFormController.birthDateController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                          child: Text(
                            "58".tr,
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
