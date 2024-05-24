import 'dart:convert';
import 'dart:io';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:get/get.dart';
import 'package:path/path.dart'; // Ensure this import for basename

class UpdateMemberLegacyProfile extends GetxController {
  final Rx<File?> selectedFile = Rx<File?>(null);

  // Set the image file
  void setImage(File file) {
    selectedFile.value = file;
    print('Image path: ${file.path}');
  }

  // Update the member profile image
  Future<void> updateImage(String memberId) async {
    if (selectedFile.value != null) {
      // Prepare data map
      Map<String, dynamic> data = {
        'memberId': memberId, // Include the memberId in the request body
      };

      var response = await NetworkHandler.postFormRequest(
        AppLink.updateMemberImage,
        data,
        includeToken: true,
        imageFile: selectedFile.value,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        // Handle the successful response, e.g., updating UI or notifying the user
        print('Image updated successfully!');
      } else {
        print('Failed to update image');
      }
    } else {
      print('No image selected');
    }
  }
}
