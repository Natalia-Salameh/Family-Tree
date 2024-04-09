// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ImageUtils {
//   static Future<String> getStorageDirectory() async {
//     final directory = Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationDocumentsDirectory();
//     return directory?.path ?? "";
//   }

//   static Future<void> uploadImage() async {
//     try {
//       // Check and request permissions
//       final permissionStatus = await Permission.photos.request();

//       if (!permissionStatus.isGranted) {
//         print('Permission to access photos is denied');
//         return;
//       }

//       final picker = ImagePicker();
//       final image = await picker.pickImage(source: ImageSource.gallery);
//       if (image == null) return;

//       final dir = await getStorageDirectory();
//       final directory = Directory(dir);

//       if (!directory.existsSync()) {
//         await directory.create(recursive: true);
//       }

//       final userImage = File(image.path);
//       final newFile = await userImage.copy('${directory.path}/userImage.png');
//       print("Image saved to ${newFile.path}");
//     } catch (e) {
//       print('Failed to upload image: $e');
//     }
//   }
// }
