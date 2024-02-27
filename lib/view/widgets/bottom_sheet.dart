import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  final Widget? child;

  const CustomBottomSheet({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 420,
              width: 400,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: builder(context),
            );
          },
        );
      },
      child: child,
    );
  }
}
