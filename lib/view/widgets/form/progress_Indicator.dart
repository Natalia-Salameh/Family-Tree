import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: LinearProgressIndicator(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        valueColor: AlwaysStoppedAnimation(CustomColors.primaryColor),
        value: progress,
        minHeight: 8,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
