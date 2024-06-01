import 'package:flutter/material.dart';
import 'package:family_tree_application/core/constants/colors.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        height: 65.0,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_outlined),
                color: selectedIndex == 0
                    ? CustomColors.primaryColor
                    : Colors.black54,
                onPressed: () => onItemTapped(0),
              ),
              Container(
                height: 30.0,
                width: 30.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.primaryColor,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 15.0, 
                  color: CustomColors.white,
                  onPressed: () => onItemTapped(1),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline_outlined),
                color: selectedIndex == 2
                    ? CustomColors.primaryColor
                    : Colors.black54,
                onPressed: () => onItemTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
