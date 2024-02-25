import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(width: 1, color: CustomColors.primaryColor),
        ),
      ),
      child: const Icon(
        Icons.person,
        size: 60,
        color: CustomColors.primaryColor,
      ),
    );
  }
}
