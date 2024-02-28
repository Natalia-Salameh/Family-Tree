import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomFloatingBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomFloatingBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: selectedIndex == 0
                  ? CustomColors.primaryColor
                  : Colors.black54,
              onPressed: () => onItemTapped(0),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.primaryColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                color: Colors.white,
                onPressed: () => onItemTapped(1),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: selectedIndex == 2
                  ? CustomColors.primaryColor
                  : Colors.black54,
              onPressed: () => onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
