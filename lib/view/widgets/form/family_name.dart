import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

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
        bottomSheetTitle: const Text(
          "Family name",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: widget.textEditingController,
            onTap: widget.isFamilyNameSelected
                ? () {
                    FocusScope.of(context).unfocus();
                    onTextFieldTap();
                  }
                : null,
            decoration: InputDecoration(
                filled: false,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.primaryColor)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1, 
                    color: Colors.black, 
                  ),
                ),
                contentPadding:
                    EdgeInsets.all(10), 
                labelText: widget.hint,
                labelStyle: TextStyle(fontSize: 12.0)),
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
