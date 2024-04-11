import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/controller/legacy_edit_controller.dart'; // Import the controller


class LegacyEdit extends StatelessWidget {
  const LegacyEdit({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LegacyEditController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Legacy",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const ProfilePicture(
            name: "Natalia Salameh",
            radius: 31,
            fontsize: 21,
          ),
          // Use the controller to provide text editing controllers for each field
          _buildListTile("Name", controller.fullNameController.value),
          const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey),
          _buildListTile("Birthday", controller.dateController.value),
          const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey),
          _buildListTile("Education", controller.educationController.value),
          const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey),
          _buildListTile("Work", controller.workController.value),
          const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey),
          _buildDiaryTile("Diary", controller.diaryController.value),
          const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildListTile(String leadingText, TextEditingController controller) {
    return ListTile(
      horizontalTitleGap: 35,
      leading: Text(leadingText),
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buildDiaryTile(String leadingText, TextEditingController controller) {
    return ListTile(
      horizontalTitleGap: 40,
      leading: Text(leadingText),
      title: TextField(
        maxLines: 2,
        controller: controller,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
