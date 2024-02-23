import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BirthdayBottomSheet extends StatelessWidget {
  final TextEditingController dateController;
  final Widget? child;

  const BirthdayBottomSheet({
    Key? key,
    required this.dateController,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 420,
      child: child,
    );
  }
}
