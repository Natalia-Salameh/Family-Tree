import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLegacy extends StatelessWidget {
  final updateLegacyController = Get.find<UpdateLegacyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Legacy")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            // Profile Picture
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: NetworkImage(updateLegacyController
            //       .photoBase64.value), // Assuming it's a base64 URL
            //   backgroundColor: Colors.grey.shade200, // Fallback color
            // ),
            SizedBox(height: 20),
            // Input fields with Cards for a neater look
            _buildInputCard(
                "First Name", updateLegacyController.firstName, "First Name"),
            _buildInputCard("Second Name", updateLegacyController.secondName,
                "Second Name"),
            _buildInputCard(
                "Third Name", updateLegacyController.thirdName, "Third Name"),
            _buildInputCard("Work", updateLegacyController.work, "Work"),
            _buildInputCard(
                "Education", updateLegacyController.education, "Education"),
            _buildInputCard(
                "Diary", updateLegacyController.legacyStory, "Diary"),
            _buildInputCard("Gender", updateLegacyController.gender, "Gender"),
            _buildDateOfBirthInputCard(
                "Date of Birth", updateLegacyController.dateOfBirth),
            // Save Changes Button
            ElevatedButton(
              onPressed: updateLegacyController.updateLegacyInfo,
              child: Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create card-styled text fields
  Widget _buildInputCard(String label, RxString value, String hintText) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        title: TextField(
          controller: TextEditingController(text: value.value),
          onChanged: (val) => value.value = val,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  // Helper method for Date of Birth input
  Widget _buildDateOfBirthInputCard(String label, Rx<DateTime> value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        title: TextField(
          controller:
              TextEditingController(text: value.value.toString().split(' ')[0]),
          onChanged: (val) => value.value = DateTime.parse(val),
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            hintText: "YYYY-MM-DD", // Suggest format
          ),
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }
}
