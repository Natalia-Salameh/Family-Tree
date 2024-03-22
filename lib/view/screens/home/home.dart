import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/view/screens/Legacy/legacy.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
import 'package:family_tree_application/view/screens/home/tree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';
import '../bottom_nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 1) {
      Get.toNamed(AppRoute.userForm);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: MockData.people.length,
          itemBuilder: (context, index) {
            String personKey = 'person${index + 1}';
            var person = MockData.people[personKey];
            return Card(
              color: Colors.white,
              shadowColor: CustomColors.black,
              elevation: 5,
              margin: const EdgeInsets.all(7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 30),
                  ListTile(
                    leading: Image.asset(
                      person?['image'],
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      person['name'],
                      style: const TextStyle(fontSize: 24),
                    ),
                    subtitle:
                        Text('${person['subject']} - ${person['location']}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 15),
                      TextButton(
                        child: const Text(
                          'View Family',
                          style: TextStyle(color: CustomColors.primaryColor),
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoute.tree);
                        },
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Center(child: FamilyTreePage()),
      const Center(child: Legacy()),
    ];
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: Text(
                'Ajial',
                style: GoogleFonts.lobster(
                  textStyle: const TextStyle(
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: CustomColors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      // Handle search button press
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                  ),
                ),
              ],
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
