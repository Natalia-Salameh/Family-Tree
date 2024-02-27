import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:family_tree_application/view/widgets/tabbar.dart';
import 'package:flutter/material.dart';

class LegacyEdit extends StatefulWidget {
  const LegacyEdit({Key? key}) : super(key: key);

  @override
  State<LegacyEdit> createState() => _UserFormState();
}

class _UserFormState extends State<LegacyEdit> {
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
