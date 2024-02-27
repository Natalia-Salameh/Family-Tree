import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';

class LegacyTabBar extends StatelessWidget {
  const LegacyTabBar({
    Key? key,
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
            Icon(Icons.groups),
            Icon(Icons.menu_book),
            Icon(Icons.info_outline),
          ],
          views: [
            Container(child: Text('Family Tree'), alignment: Alignment.center),
            Container(child: Text('diary'), alignment: Alignment.center),
            Container(child: Text('information'), alignment: Alignment.center),
          ],
        ),
      ),
    );
  }
}
