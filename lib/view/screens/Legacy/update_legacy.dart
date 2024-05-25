import 'package:drop_down_list/model/selected_list_item.dart';
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
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              _buildSectionHeader('Personal Information'),
              _buildDropdown(),
              _buildTextField("First Name", updateLegacyController.firstName),
              _buildTextField("Second Name", updateLegacyController.secondName),
              _buildTextField("Third Name", updateLegacyController.thirdName),
              SizedBox(height: 20),
              _buildSectionHeader('Professional Information'),
              _buildTextField("Location", updateLegacyController.location),
              _buildTextField("Work", updateLegacyController.work),
              SizedBox(height: 20),
              _buildSectionHeader('Personal Story'),
              _buildTextField("Diary", updateLegacyController.legacyStory),
              _buildTextField("Gender", updateLegacyController.gender),
              _buildDateOfBirthInputCard(
                  context, "Date of Birth", updateLegacyController.dateOfBirth),
              SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: updateLegacyController.updateLegacyInfo,
              //     child: Text("Save Changes"),
              //     style: ElevatedButton.styleFrom(
              //       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              //       textStyle: TextStyle(fontSize: 16),
              //     ),
              //   ),),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String label, RxString rxValue) {
    final controller = TextEditingController(text: rxValue.value);
    controller.addListener(() {
      rxValue.value = controller.text;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
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
          var selectedItem = familyNameController.familyNames.value.firstWhere(
              (item) => item.value == newFamilyId,
              orElse: () => SelectedListItem(value: '', name: ''));
          updateLegacyController.setSelectedFamily(
              newFamilyId, selectedItem.name);
        }
      },
      items: familyNameController.familyNames.value.map((item) {
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
