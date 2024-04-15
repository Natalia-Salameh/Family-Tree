import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
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
                           onTap: () {
                              final memberLegacyController =
                                  MemberLegacyController.to;
                              final updateLegacyController =
                                  Get.put(UpdateLegacyController());
                              updateLegacyController
                                  .loadInitialData(memberLegacyController);
                              Get.to(() => EditLegacy());
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
              child: Column(
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
                      "${legacyController.firstName} ${legacyController.secondName} ${legacyController.thirdName} ${legacyController.family.familyName}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 10),
                  LegacyTabBar(
                    views: [
                      Container(
                          alignment: Alignment.center, child: Text("44".tr)),
                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text("Education"),
                                subtitle: Text(
                                  legacyController.education == ""
                                      ? "No Education added"
                                      : legacyController.education,
                                ),
                              ),
                              ListTile(
                                title: const Text("Work"),
                                subtitle: Text(
                                  legacyController.work == ""
                                      ? "No Work added"
                                      : legacyController.work,
                                ),
                              ),
                              ListTile(
                                title: const Text("Diary"),
                                subtitle: Text(
                                  legacyController.legacyStory == ""
                                      ? "No Diary added"
                                      : legacyController.legacyStory,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text("Gender"),
                                subtitle: Text(
                                  legacyController.gender == ""
                                      ? "No Gender added"
                                      : legacyController.gender,
                                ),
                              ),
                              ListTile(
                                title: const Text("Date of Birth"),
                                subtitle: Text(
                                  legacyController.dateOfBirth == null
                                      ? "No Date of Birth added"
                                      : legacyController.dateOfBirth
                                          .toString()
                                          .split(' ')[0],
                                ),
                              ),
                            ],
                          )),
                    ],
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
