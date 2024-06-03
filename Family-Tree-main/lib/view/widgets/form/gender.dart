import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/enums.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String label;
  final dynamic genderValue;
  final dynamic selectedGender;
  final void Function(String?) onGenderSelected;

  const RadioButton({
    Key? key,
    required this.label,
    required this.genderValue,
    required this.selectedGender,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      activeColor: CustomColors.primaryColor,
      onChanged: onGenderSelected,
      groupValue: selectedGender.toString(),
      value: genderValue.toString(),
      title: Text(label, style: TextStyle(fontSize: 14)),
    );
  }
}
