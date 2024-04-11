import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';

class Legacy extends StatelessWidget {
  const Legacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Legacy",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text("Settings"),
                            onTap: () {
                              Get.toNamed(AppRoute.settings);
                            },
                          ),
                          const Divider(
                            height: 1,
                            indent: 40,
                            endIndent: 40,
                            thickness: 1,
                            color: CustomColors.lightGrey,
                          ),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit legacy"),
                            onTap: () {
                              Get.toNamed(AppRoute.editLegacy);
                            },
                          ),
                          const Divider(
                            indent: 40,
                            endIndent: 40,
                            height: 1,
                            thickness: 1,
                            color: CustomColors.lightGrey,
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.dehaze_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ProfilePicture(
                      name: "Natalia Salameh",
                      radius: 31,
                      fontsize: 21,
                    ),
                  ),
                  const Text("Natalia Salameh"),
                  const SizedBox(height: 10),
                  LegacyTabBar(
                    views: [
                      Container(
                          alignment: Alignment.center,
                          child: const Text('Family Tree')),
                      Container(
                          alignment: Alignment.center,
                          child: const Text('diary')),
                      Container(
                          alignment: Alignment.center,
                          child: const Text('information')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
