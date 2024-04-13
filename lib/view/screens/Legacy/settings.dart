import 'package:family_tree_application/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // This controller is necessary for updating the GetX UI when changing languages
    final RxString currentLanguage = RxString(Get.locale?.languageCode ?? 'en');

    void switchLanguage(String langCode) {
      Locale newLocale = Locale(langCode, '');
      Get.updateLocale(newLocale);
      currentLanguage.value = langCode;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "43".tr, // Assuming "43" is for 'Settings'
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text("46".tr), // Assuming "46" is for 'Logout'
              onPressed: () {
                LoginController().logout();
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Change Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => DropdownButton<String>(
                  value: currentLanguage.value,
                  icon: const Icon(Icons.language),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      switchLanguage(newValue);
                    }
                  },
                  items: <String>['en', 'ar']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'en' ? 'English' : 'Arabic'),
                    );
                  }).toList(),
                )),
          ],
        ),
      ),
    );
  }
}
