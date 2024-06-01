import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/controller/update_legacy_controller.dart';
import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/login_controller.dart';
import 'package:intl/intl.dart'; // for date formatting

class EditLegacy extends StatelessWidget {
  final FamilyNameController familyNameController = Get.put(FamilyNameController());
  final UpdateLegacyController updateLegacyController = Get.find<UpdateLegacyController>();
  final RxString currentLanguage = RxString(Get.locale?.languageCode ?? 'en');

  void switchLanguage(String langCode) {
    Locale newLocale = Locale(langCode, '');
    Get.updateLocale(newLocale);
    currentLanguage.value = langCode;
  }

  void showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => DropdownButton<String>(
                  value: currentLanguage.value,
                  icon: const Icon(Icons.language, color: Colors.black),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black87),
                  underline: Container(
                    height: 2,
                    color: Colors.black87,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      switchLanguage(newValue);
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                  items: <String>['en', 'ar']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value == 'en' ? 'English' : 'Arabic',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Legacy'),
        actions: [
          MaterialButton(
              child: Text("Save"),
              onPressed: () => updateLegacyController.updateLegacyInfo())
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
              _buildSettingsTile(
                context,
                "Change Language",
                Icons.language,
                () {
                  showLanguagePicker(context);
                },
              ),
              _buildSettingsTile(
                context,
                "Logout",
                Icons.logout,
                () {
                  LoginController().logout();
                },
              ),
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

  Widget _buildSettingsTile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
