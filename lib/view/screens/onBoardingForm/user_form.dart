import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/Tree.dart';
import 'package:family_tree_application/view/widgets/bottom_sheet.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late DateTime dateTime;
  double progress = 0.0;

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
                  const SizedBox(height: 30),
                  const Text(
                    "Lets get started by adding you first, fill these in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(26),
                    child: Profile(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextForm(
                          hintText: "Full name",
                          myController: fullNameController,
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
                  Row(children: [
                    const Expanded(
                        flex: 0,
                        child: Text(
                          "Gender: ",
                          style: TextStyle(fontSize: 16),
                        )),
                    Expanded(
                        flex: 1,
                        child: RadioButton(
                            label: "Female",
                            genderValue: Gender.female,
                            selectedGender: MockData.groupValue,
                            onGenderSelected: (val) {
                              setState(() {
                                MockData.groupValue = val!;
                              });
                            })),
                    Expanded(
                        flex: 1,
                        child: RadioButton(
                            label: "Male",
                            genderValue: Gender.male,
                            selectedGender: MockData.groupValue,
                            onGenderSelected: (val) {
                              setState(() {
                                MockData.groupValue = val!;
                              });
                            })),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => BirthdayBottomSheet(
                          dateController: dateController,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime value) {
                              final dateTimeText =
                                  "${value.year}-${value.month}-${value.day}";
                              dateController.text = dateTimeText;
                            },
                          ),
                        ),
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
                    height: 140,
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        onPressed: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TreeState(
                                  progress: progress,
                                ),
                              ),
                              (route) => false,
                            );
                            progress = progress + 0.5;
                          });
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
    );
  }
}
