import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Legacy extends StatefulWidget {
  const Legacy({Key? key}) : super(key: key);

  @override
  State<Legacy> createState() => _UserFormState();
}

class _UserFormState extends State<Legacy> {
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
                            onTap: () {},
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
                              Navigator.of(context)
                                  .pushNamed(AppRoute.editLegacy);
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
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ProfilePicture(
                      name: "Natalia Salameh",
                      radius: 31,
                      fontsize: 21,
                    ),
                  ),
                  Text("Natalia Salameh"),
                  SizedBox(height: 10),
                  LegacyTabBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
