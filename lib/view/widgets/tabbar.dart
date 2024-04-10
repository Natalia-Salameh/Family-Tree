import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegacyTabBar extends StatelessWidget {
  final List<Widget> views;

  const LegacyTabBar({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 450,
        height: 500,
        child: ContainedTabBarView(
          tabBarProperties: const TabBarProperties(
              indicatorColor: CustomColors.primaryColor,
              labelColor: CustomColors.primaryColor),
          tabs: const [
            Icon(Icons.groups_outlined),
            Icon(CupertinoIcons.book),
            Icon(CupertinoIcons.info_circle),
          ],
          views: views,
        ),
      ),
    );
  }
}
