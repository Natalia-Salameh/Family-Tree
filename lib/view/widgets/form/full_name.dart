import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController myController;
  final int maxLines;
  final bool alignLabelWithHint;
  // final String? Function(String?) valid;

  const CustomTextForm({
    Key? key,
    required this.hintText,
    required this.myController,
    this.maxLines = 1,
    this.alignLabelWithHint = false,
    // required this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        //    validator: valid,
        maxLines: maxLines,
        controller: myController,
        decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 12),
            alignLabelWithHint: alignLabelWithHint,
            labelText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }
}
