import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/bottom_sheet.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';

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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CustomBottomSheet(
            builder: (context) => Column(
              children: [
                Container(
                  height: 40,
                  width: 250,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 196, 196, 196))),
                  ),
                ),
                Container(
                  height: 40,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: CustomColors.background)),
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Text(
                      "Settings",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: CustomColors.background)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoute.editLegacy);
                    },
                    child: const Text(
                      "Edit legacy",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.list),
            ),
          ),
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
                    child: Profile(),
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
