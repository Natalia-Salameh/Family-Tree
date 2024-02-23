import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController myController;
  // final String? Function(String?) valid;

  const CustomTextForm({
    Key? key,
    required this.hintText,
    required this.myController,
    // required this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
          //    validator: valid,
          controller: myController,
          decoration: InputDecoration(
              labelStyle: const TextStyle(fontSize: 12),
              labelText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.primaryColor)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
    );
  }
}
