import 'dart:io';

import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:family_tree_application/controller/update_profile_image_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/Legacy/member_tree.dart';
import 'package:family_tree_application/view/screens/Legacy/update_legacy.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Legacy extends StatelessWidget {
  Legacy({super.key});
  final legacyController = Get.put(MemberLegacyController());
  final updateController = Get.put(UpdateMemberLegacyProfile());
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
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        if (legacyController.imageBytes != null)
                          CircleAvatar(
                            radius:
                                60, // Slightly increased size for visual enhancement
                            backgroundImage:
                                MemoryImage(legacyController.imageBytes!),
                          )
                        else
                          const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.person,
                                size: 70), // Adjusted size for consistency
                          ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Light background color for the icon
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit_sharp,
                                color: Colors.blue),
                            onPressed: () => _selectAndUploadImage(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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

  void _selectAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    // Show choice dialog to the user
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose option'),
          content: Text(
              'Would you like to take a photo or choose from your gallery?'),
          actions: <Widget>[
            TextButton(
              child: Text('Camera'),
              onPressed: () async {
                Navigator.pop(context);
                pickedFile = await picker.pickImage(source: ImageSource.camera);
                _processPickedFile(pickedFile);
              },
            ),
            TextButton(
              child: Text('Gallery'),
              onPressed: () async {
                Navigator.pop(context);
                pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                _processPickedFile(pickedFile);
              },
            ),
          ],
        );
      },
    );
  }

  void _processPickedFile(XFile? pickedFile) async {
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      updateController.setImage(imageFile);
      await updateController.updateImage(legacyController.family.value.id);
      // Reload the legacy info after updating the image
      legacyController.legacyInfo();
    } else {
      // Handle the user not selecting an image
      Get.snackbar(
          'No Image Selected', 'You have not selected any image to upload.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
