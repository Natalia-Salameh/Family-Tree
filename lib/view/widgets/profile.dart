import 'dart:io';

import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class Profile extends StatelessWidget {
  final Function(File) onImagePicked;

  const Profile({
    super.key,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Stack(
        children: [
          Transform.scale(
              scale: 0.6,
              child: ImagePickerWidget(
                fit: BoxFit.cover,
                diameter: 140,
                shape: ImagePickerWidgetShape.circle,
                modalOptions: ModalOptions(
                    cameraColor: CustomColors.primaryColor,
                    galleryColor: CustomColors.primaryColor),
                isEditable: true,
                imagePickerOptions: ImagePickerOptions(imageQuality: 6),
                onChange: (File file) {
                  print("I changed the file to: ${file.path}");
                  onImagePicked(file);
                },
              )),
        ],
      ),
    );
  }
}
