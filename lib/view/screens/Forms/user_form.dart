import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserForm extends StatelessWidget {
  final UserFormController controller = Get.put(UserFormController());

  UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Profile(),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 40,
                          child: CustomTextForm(
                            hintText: "Full name",
                            myController: controller.fullNameController,
                            
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FamilyNameDropDown(
                            textEditingController:
                                controller.lastNameController,
                            hint: "Family name",
                            isFamilyNameSelected: true,
                            familyNames: MockData.familyName),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                            selectedGender: controller.selectedGender.value,
                            onGenderSelected: (val) {
                              controller.updateGender(Gender.female);
                            },
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(() => RadioButton(
                            label: "Male",
                            genderValue: Gender.male,
                            selectedGender: controller.selectedGender.value,
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CupertinoButton(
                                    child: const Text("Done",
                                        style: TextStyle(
                                            color: CustomColors.primaryColor)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
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
                        height: 40,
                        child: CustomTextForm(
                          hintText: "Birthday",
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
                    child: CustomTextForm(
                      hintText: "Education",
                      myController: controller.educationController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomTextForm(
                      hintText: "Work",
                      myController: controller.workController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                      onPressed: () {
                        // showModalBottomSheet(
                        //     showDragHandle: true,
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.vertical(
                        //         top: Radius.circular(15),
                        //       ),
                        //     ),
                        //     context: context,
                        //     builder: (context) {
                        //       return Row(

                        //       );
                        //     });
                      },
                      color: CustomColors.primaryColor,
                      child: const Text(
                        "Add",
                        style: TextStyle(color: CustomColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
