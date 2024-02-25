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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_square),
          )
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
