import 'package:family_tree_application/core/constants/imageasset.dart';
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
      // child: Row(
      //   children: [
      //     MaterialButton(
      //         child: const Icon(
      //           Icons.arrow_back_ios,
      //         ),
      //         onPressed: () {}),
      //     MaterialButton(
      //         child: Image.asset(
      //           AppImageAsset.father,
      //         ),
      //         onPressed: () {}),
      //     MaterialButton(
      //         child: const Icon(Icons.arrow_forward_ios), onPressed: () {}),
      //   ],
      // ),
    );
  }
}
