import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/Legacy/member_tree.dart';
import 'package:family_tree_application/view/screens/Legacy/update_legacy.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';

class Legacy extends StatelessWidget {
  Legacy({super.key});
  final legacyController = Get.put(MemberLegacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "42".tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: Text("43".tr),
                            onTap: () {
                              Get.toNamed(AppRoute.settings);
                            },
                          ),
                          const Divider(
                            height: 1,
                            indent: 40,
                            endIndent: 40,
                            thickness: 1,
                            color: CustomColors.lightGrey,
                          ),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: Text("39".tr),
                            onTap: () async {
                              // This will create UpdateLegacyController only when it's needed
                              Get.lazyPut(() => UpdateLegacyController());

                              // Now we can find UpdateLegacyController without error
                              final updateLegacyController =
                                  Get.find<UpdateLegacyController>();

                              // If MemberLegacyController is already put in GetX storage,
                              // we can retrieve it like this:
                              final memberLegacyController =
                                  Get.find<MemberLegacyController>();

                              // Load initial data from MemberLegacyController into UpdateLegacyController
                              updateLegacyController
                                  .loadInitialData(memberLegacyController);

                              // Navigate to EditLegacy
                              var result = await Get.to(() => EditLegacy());
                              if (result == 'updateSuccessful') {
                                memberLegacyController.legacyInfo();
                              }
                            },
                          ),
                          const Divider(
                            indent: 40,
                            endIndent: 40,
                            height: 1,
                            thickness: 1,
                            color: CustomColors.lightGrey,
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.dehaze_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(() {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ProfilePicture(
                        name: "Natalia Salameh",
                        radius: 31,
                        fontsize: 21,
                      ),
                    ),
                    Text(
                        "${legacyController.firstName.value} ${legacyController.secondName.value} ${legacyController.thirdName.value} ${legacyController.family.value.familyName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    LegacyTabBar(
                      views: [
                        Container(
                            alignment: Alignment.center,
                            child: const MemberFamilyTreePage()),
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("35".tr),
                                  subtitle: Text(
                                    legacyController.education.value.isEmpty
                                        ? "No Education added"
                                        : legacyController.education.value,
                                  ),
                                ),
                                ListTile(
                                  title: Text("36".tr),
                                  subtitle: Text(
                                    legacyController.work.value.isEmpty
                                        ? "No Work added".tr
                                        : legacyController.work.value,
                                  ),
                                ),
                                ListTile(
                                  title: Text("41".tr),
                                  subtitle: Text(
                                    legacyController.legacyStory.value.isEmpty
                                        ? "No Diary added".tr
                                        : legacyController.legacyStory.value,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("30".tr),
                                  subtitle: Text(
                                    legacyController.gender.value.isEmpty
                                        ? "No Gender added".tr
                                        : legacyController.gender.value,
                                  ),
                                ),
                                ListTile(
                                  title: Text("DateofBirth".tr),
                                  subtitle: Text(
                                    legacyController.dateOfBirth.value == null
                                        ? "No Date of Birth added"
                                        : legacyController.dateOfBirth.value
                                            .toString()
                                            .split(' ')[0],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
