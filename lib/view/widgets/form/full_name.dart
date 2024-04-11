import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController myController;
  final int maxLines;
  final bool alignLabelWithHint;
  final String? Function(String?)? valid;

  const CustomTextForm({
    Key? key,
    required this.hintText,
    required this.myController,
    this.maxLines = 1,
    this.alignLabelWithHint = false,
    this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: CustomColors.primaryColor,
      validator: valid,
      maxLines: maxLines,
      controller: myController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        labelText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
