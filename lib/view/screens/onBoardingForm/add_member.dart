import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/tree.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:family_tree_application/view/widgets/bottom_sheet.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAdd extends StatefulWidget {
  final String role; // Role is passed when navigating to this screen
  const UserAdd({Key? key, required this.role}) : super(key: key);

  @override
  State<UserAdd> createState() => _UserFormState();
}

class _UserFormState extends State<UserAdd> {
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
                  ProgressBar(
                    progress: progress,
                  ),
                  const SizedBox(height: 20),
                  // const Padding(
                  //   padding: EdgeInsets.all(26),
                  //   child: Profile(),
                  // ),
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
                      // Expanded(
                      //   child: FamilyNameDropDown(
                      //       textEditingController: lastNameController,
                      //       hint: "Family name",
                      //       isFamilyNameSelected: true,
                      //       familyNames: MockData.familyName
                      //       ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                            height: 300,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime value) {
                                // Format the date and update the field when the date is changed
                                final dateTimeText =
                                    "${value.year}-${value.month}-${value.day}";
                                setState(() {
                                  dateController.text = dateTimeText;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomTextForm(
                        hintText: "Birthday",
                        myController: dateController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                          setState(() {
                            String firstName =
                                fullNameController.text.split(" ")[0];
                            Get.back(result: {
                              'role': widget.role,
                              'firstName': firstName,
                            });
                          });
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
