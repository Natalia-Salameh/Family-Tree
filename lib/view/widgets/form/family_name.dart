import 'package:family_tree_application/controller/family_name_controller.dart';
import 'package:family_tree_application/controller/member_form_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/view/screens/Forms/spouse_form.dart';
import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:get/get.dart';

class FamilyNameDropDown extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final bool isFamilyNameSelected;

  const FamilyNameDropDown({
    required this.textEditingController,
    required this.hint,
    required this.isFamilyNameSelected,
    Key? key,
  }) : super(key: key);

  @override
  _FamilyNameDropDownState createState() => _FamilyNameDropDownState();
}

class _FamilyNameDropDownState extends State<FamilyNameDropDown> {
  final FamilyNameController controller = Get.find<FamilyNameController>();
  MemberFormController memberFormController = Get.put(MemberFormController());
  UserFormController userFormController = Get.put(UserFormController());
  SpouseFormController spouseFormController = Get.put(SpouseFormController());

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
        data: controller.familyNames,
        selectedItems: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty &&
              selectedList.first is SelectedListItem) {
            final selectedName = (selectedList.first as SelectedListItem).name;
            widget.textEditingController.text = selectedName;
            final selectedNameID =
                (selectedList.first as SelectedListItem).value;
            print("Selected ID: $selectedNameID");
            memberFormController.idController.text = selectedNameID!;
            userFormController.idController.text = selectedNameID;
            spouseFormController.idController.text = selectedNameID;
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.familyNames.isEmpty) {
        return const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white38),
        );
      }

      return TextFormField(
        controller: widget.textEditingController,
        onTap: widget.isFamilyNameSelected
            ? () {
                FocusScope.of(context).unfocus();
                onTextFieldTap();
              }
            : null,
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 12),
          alignLabelWithHint: true,
          labelText: "29".tr,
          hintStyle: const TextStyle(fontSize: 14),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.primaryColor),
          ),
        ),
        style: const TextStyle(fontSize: 14.0),
        validator: (value) => value!.isEmpty ? "52".tr : null,
      );
    });
  }
}
