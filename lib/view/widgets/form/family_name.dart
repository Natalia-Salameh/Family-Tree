import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyNameDropDown extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final bool isFamilyNameSelected;
  final List<SelectedListItem>? familyNames;

  const FamilyNameDropDown({
    required this.textEditingController,
    required this.hint,
    required this.isFamilyNameSelected,
    this.familyNames,
    Key? key,
  }) : super(key: key);

  @override
  _FamilyNameDropDownState createState() => _FamilyNameDropDownState();
}

class _FamilyNameDropDownState extends State<FamilyNameDropDown> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: Text(
          "29".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        data: widget.familyNames ?? [],
        selectedItems: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty &&
              selectedList.first is SelectedListItem) {
            final selectedName = (selectedList.first as SelectedListItem).name;
            widget.textEditingController.text = selectedName;
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      onTap: widget.isFamilyNameSelected
          ? () {
              FocusScope.of(context).unfocus();
              onTextFieldTap();
            }
          : null,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        alignLabelWithHint: true,
        labelText: "29".tr,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.primaryColor,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 14.0,
      ),
      validator: (value) => value!.isEmpty ? "52".tr : null,
    );
  }
}
