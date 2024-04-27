import 'package:family_tree_application/controller/user_legacy_controller.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';

class UserLegacy extends StatelessWidget {
  UserLegacy({super.key});
  final userLegacyController = Get.put(UserLegacyController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userLegacyController.legacyInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
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
                            name: "",
                            radius: 31,
                            fontsize: 21,
                          ),
                        ),
                        Text(
                            "${userLegacyController.firstName} ${userLegacyController.secondName} ${userLegacyController.thirdName} ${userLegacyController.family.familyName}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 10),
                        LegacyTabBar(
                          views: [
                            Container(
                                alignment: Alignment.center,
                                child: Text("44".tr)),
                            Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("35".tr),
                                      subtitle: Text(
                                        userLegacyController.education == ""
                                            ? "No Education added"
                                            : userLegacyController.education,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("36".tr),
                                      subtitle: Text(
                                        userLegacyController.work == ""
                                            ? "No Work added"
                                            : userLegacyController.work,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("41".tr),
                                      subtitle: Text(
                                        userLegacyController.legacyStory == ""
                                            ? "No Diary added"
                                            : userLegacyController.legacyStory,
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
                                        userLegacyController.gender == ""
                                            ? "No Gender added"
                                            : userLegacyController.gender,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("DateofBirth".tr),
                                      subtitle: Text(
                                        userLegacyController.dateOfBirth == null
                                            ? "No Date of Birth added"
                                            : userLegacyController.dateOfBirth
                                                .toString()
                                                .split('T')[0],
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
      },
    );
  }
}
