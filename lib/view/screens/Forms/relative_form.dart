import 'dart:io';

import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  State<UserAdd> createState() => _UserFormState();
}

class _UserFormState extends State<UserAdd> {
  final UserFormController controller = Get.put(UserFormController());

  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController materialStateController = TextEditingController();

  late DateTime dateTime;
  double progress = 0.0;

  void _handleLifeStatusChange(LifeStatus? value) {
    setState(() {
      MockData.lifeStatusValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  const Profile(),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 40,
                          child: CustomTextForm(
                            hintText: "Full name",
                            myController: fullNameController,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FamilyNameDropDown(
                            textEditingController: lastNameController,
                            hint: "Family name",
                            isFamilyNameSelected: true,
                            familyNames: MockData.familyName),
                      ),
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
                                    child: const Text("Done",
                                        style: TextStyle(
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
                      hintText: "Material State",
                      myController: materialStateController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 0,
                          child: Text(
                            "Still Alive:",
                            style: TextStyle(fontSize: 16),
                          )),
                      Expanded(
                        child: ListTile(
                          title: const Text('Yes'),
                          leading: Radio<LifeStatus>(
                            value: LifeStatus.alive,
                            groupValue: MockData.lifeStatusValue,
                            onChanged: _handleLifeStatusChange,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('No'),
                          leading: Radio<LifeStatus>(
                            value: LifeStatus.dead,
                            groupValue: MockData.lifeStatusValue,
                            onChanged: _handleLifeStatusChange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AbsorbPointer(
                    child: SizedBox(
                      height: 40,
                      child: CustomTextForm(
                        hintText: "Death Date",
                        myController: dateController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        onPressed: () {
                          Get.toNamed(AppRoute.treeForm);
                        },
                        color: CustomColors.primaryColor,
                        child: const Text(
                          "Add",
                          style: TextStyle(color: CustomColors.white),
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
