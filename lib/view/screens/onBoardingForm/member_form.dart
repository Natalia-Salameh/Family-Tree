import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/tree.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/family_name.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/gender.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberForm extends StatefulWidget {
  const MemberForm({Key? key}) : super(key: key);

  @override
  State<MemberForm> createState() => _UserFormState();
}

class _UserFormState extends State<MemberForm> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController workController = TextEditingController();
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
                  Padding(
                    padding: EdgeInsets.all(26),
                    child: Stack(
                      children: [
                        const Profile(),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined,
                                  size: 16),
                              color: CustomColors.primaryColor,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                    dateController.text = dateTimeText;
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
                          myController: dateController,
                        ),
                      ),
                    ),
                  ),

                  // CustomBottomSheet(
                  //   builder: (context) => CupertinoDatePicker(
                  //     mode: CupertinoDatePickerMode.date,
                  //     onDateTimeChanged: (DateTime value) {
                  //       final dateTimeText =
                  //           "${value.year}-${value.month}-${value.day}";
                  //       dateController.text = dateTimeText;
                  //     },
                  //   ),
                  //   child: AbsorbPointer(
                  //     child: SizedBox(
                  //       height: 40,
                  //       child: CustomTextForm(
                  //         hintText: "Birthday",
                  //         myController: dateController,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // CupertinoActionSheet(
                  //   title: Text("data"),
                  //   actions: [
                  //   CupertinoDatePicker(
                  //     mode: CupertinoDatePickerMode.date,
                  //     onDateTimeChanged: (DateTime value) {
                  //       final dateTimeText =
                  //           "${value.year}-${value.month}-${value.day}";
                  //       dateController.text = dateTimeText;
                  //     },
                  //   ),
                  //   AbsorbPointer(
                  //     child: SizedBox(
                  //       height: 40,
                  //       child: CustomTextForm(
                  //         hintText: "Birthday",
                  //         myController: dateController,
                  //       ),
                  //     ),
                  //   ),
                  // ]),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomTextForm(
                      hintText: "Education",
                      myController: educationController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomTextForm(
                      hintText: "Work",
                      myController: workController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
