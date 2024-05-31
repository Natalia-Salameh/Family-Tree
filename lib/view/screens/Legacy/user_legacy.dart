import 'package:family_tree_application/controller/user_legacy_controller.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/Legacy/user_tree.dart';
import 'package:family_tree_application/view/widgets/bottom_nav.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';

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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAllNamed(AppRoute.home);
                },
              ),
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
                        if (userLegacyController.imageBytes != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CircleAvatar(
                              radius: 50, // Adjust the size as needed
                              backgroundImage:
                                  MemoryImage(userLegacyController.imageBytes!),
                            ),
                          )
                        else
                          CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.person, size: 60), // Default icon
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
                                child: const FamilyTreePage()),
                            Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("35".tr),
                                      subtitle: Text(
                                        userLegacyController.location == ""
                                            ? "No Location added"
                                            : userLegacyController.location,
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
                                    // ListTile(
                                    //   title: Text("Date of Death".tr),
                                    //   subtitle: Text(
                                    //     userLegacyController.dateOfBirth == null
                                    //         ? "No Date of Death added"
                                    //         : userLegacyController.dateOfDeath
                                    //             .toString()
                                    //             .split('T')[0],
                                    //   ),
                                    // ),
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
            bottomNavigationBar: CustomFloatingBottomBar(
              selectedIndex: 0,
              onItemTapped: (index) {
                if (index == 0) {
                  Get.offNamed(AppRoute.home);
                } else if (index == 1) {
                  Get.toNamed(AppRoute.userForm);
                } else if (index == 2) {
                  Get.offNamed(AppRoute.legacy);
                }
              },
            ),
          );
        }
      },
    );
  }
}
