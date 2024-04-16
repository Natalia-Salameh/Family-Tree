import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:intl/intl.dart'; // for date formatting

class EditLegacy extends StatelessWidget {
  final FamilyNameController familyNameController =
      Get.put(FamilyNameController());
  final UpdateLegacyController updateLegacyController =
      Get.find<UpdateLegacyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Legacy'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => updateLegacyController.updateLegacyInfo(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          return Column(
            children: <Widget>[
              _buildDropdown(),
              SizedBox(height: 20),
              _buildTextField("First Name", updateLegacyController.firstName),
              _buildTextField("Second Name", updateLegacyController.secondName),
              _buildTextField("Third Name", updateLegacyController.thirdName),
              _buildTextField("Education", updateLegacyController.education),
              _buildTextField("Work", updateLegacyController.work),
              _buildTextField("Diary", updateLegacyController.legacyStory),
              _buildTextField("Gender", updateLegacyController.gender),
              _buildDateOfBirthInputCard(
                  context, "Date of Birth", updateLegacyController.dateOfBirth),
              _buildTextField(
                  "Photo Base64", updateLegacyController.photoBase64),
              ElevatedButton(
                onPressed: updateLegacyController.updateLegacyInfo,
                child: Text("Save Changes"),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTextField(String label, RxString rxValue) {
    // Create a TextEditingController that is linked to the RxString
    final controller = TextEditingController(text: rxValue.value);
    controller.addListener(() {
      rxValue.value = controller.text; // Update RxString on change
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        // onChanged is not needed because we're using a listener on the controller
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Family',
        border: OutlineInputBorder(),
      ),
      value: updateLegacyController.selectedFamilyId.value.isNotEmpty
          ? updateLegacyController.selectedFamilyId.value
          : null,
      onChanged: (String? newFamilyId) {
        if (newFamilyId != null) {
          updateLegacyController.setSelectedFamily(newFamilyId);
        }
      },
      items: familyNameController.familyNames.value
          .map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: Text(item.name),
        );
      }).toList(),
    );
  }

  Widget _buildDateOfBirthInputCard(
      BuildContext context, String label, Rx<DateTime> rxValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: rxValue.value,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            rxValue.value = pickedDate;
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd').format(rxValue.value)),
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
