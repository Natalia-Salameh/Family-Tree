// import 'package:family_tree_application/core/constants/colors.dart';
// import 'package:family_tree_application/enums.dart';
// import 'package:family_tree_application/mock_data.dart';
// import 'package:family_tree_application/view/widgets/button.dart';
// import 'package:family_tree_application/view/widgets/form/full_name.dart';
// import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class UserAdd extends StatefulWidget {
//   final String role; // Role is passed when navigating to this screen
//   const UserAdd({Key? key, required this.role}) : super(key: key);

//   @override
//   State<UserAdd> createState() => _UserFormState();
// }

// class _UserFormState extends State<UserAdd> {
//   final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController materialStateController = TextEditingController();
//   late DateTime dateTime;
//   double progress = 0.0;

//   void _handleLifeStatusChange(LifeStatus? value) {
//     setState(() {
//       MockData.lifeStatusValue = value!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   ProgressBar(
//                     progress: progress,
//                   ),
//                   const SizedBox(height: 10),
//                   // const Padding(
//                   //   padding: EdgeInsets.all(10),
//                   //   child: Profile(),
//                   // ),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: SizedBox(
//                           height: 64,
//                           child: CustomTextForm(
//                             hintText: "28".tr,
//                             myController: fullNameController,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       // Expanded(
//                       //   child: FamilyNameDropDown(
//                       //       textEditingController: lastNameController,
//                       //       hint: "29".tr,
//                       //       isFamilyNameSelected: true,
//                       //       familyNames: MockData.familyName
//                       //       ),
//                       // ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext builder) {
//                           return Container(
//                             height: 300,
//                             child: CupertinoDatePicker(
//                               mode: CupertinoDatePickerMode.date,
//                               onDateTimeChanged: (DateTime value) {
//                                 // Format the date and update the field when the date is changed
//                                 final dateTimeText =
//                                     "${value.year}-${value.month}-${value.day}";
//                                 setState(() {
//                                   dateController.text = dateTimeText;
//                                 });
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: AbsorbPointer(
//                       child: CustomTextForm(
//                         hintText: "34".tr,
//                         myController: dateController,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: CustomTextForm(
//                       hintText: "47".tr,
//                       myController: materialStateController,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                           flex: 0,
//                           child: Text(
//                             "48".tr,
//                             style: const TextStyle(fontSize: 16),
//                           )),
//                       Expanded(
//                         child: ListTile(
//                           title: Text("49".tr),
//                           leading: Radio<LifeStatus>(
//                             value: LifeStatus.alive,
//                             groupValue: MockData.lifeStatusValue,
//                             onChanged: _handleLifeStatusChange,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           title: Text("50".tr),
//                           leading: Radio<LifeStatus>(
//                             value: LifeStatus.dead,
//                             groupValue: MockData.lifeStatusValue,
//                             onChanged: _handleLifeStatusChange,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   AbsorbPointer(
//                     child: SizedBox(
//                       height: 40,
//                       child: CustomTextForm(
//                         hintText: "51".tr,
//                         myController: dateController,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: Button(
//                         onPressed: () {
//                           setState(() {
//                             String firstName =
//                                 fullNameController.text.split(" ")[0];
//                             Get.back(result: {
//                               'role': widget.role,
//                               'firstName': firstName,
//                             });
//                           });
//                         },
//                         color: CustomColors.primaryColor,
//                         child: Text(
//                           "37".tr,
//                           style: const TextStyle(color: CustomColors.white),
//                         )),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
