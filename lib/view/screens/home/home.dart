import 'package:family_tree_application/constants/colors.dart';
import 'package:family_tree_application/constants/routes.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
import 'package:family_tree_application/view/screens/home/tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/imageasset.dart';
import '../bottom_nav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Map of people with their details
  final Map<String, dynamic> people = {
    'person1': {
      'name': 'Alex Smith',
      'subject': 'Mathematics',
      'location': 'New York',
      'image': AppImageAsset.father,
    },
    'person2': {
      'name': 'Maria Garcia',
      'subject': 'Biology',
      'location': 'Los Angeles',
      'image': AppImageAsset.child,
    },
    'person3': {
      'name': 'John Doe',
      'subject': 'History',
      'location': 'Chicago',
      'image': AppImageAsset.profile,
    },
    'person4': {
      'name': 'Alex Smith',
      'subject': 'Mathematics',
      'location': 'New York',
      'image': AppImageAsset.mother,
    },
    'person5': {
      'name': 'Maria Garcia',
      'subject': 'Biology',
      'location': 'Los Angeles',
      'image': AppImageAsset.child,
    },
    // Add more people as needed
  };
  Tree personTree = Tree();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            String personKey = 'person${index + 1}';
            var person = people[personKey];
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 15),
                  ListTile(
                    leading: Image.asset(
                      person?['image'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      person['name'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle:
                        Text('${person['subject']} - ${person['location']}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      TextButton(
                        child: const Text(
                          'View Family',
                          style: TextStyle(color: CustomColors.myCustomColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FamilyTreeViewPage(tree: personTree),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      const Center(child: Text('Add Page')),
      const Center(child: Text('Profile Page')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajial',
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              color: CustomColors.myBlack,
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
                color: CustomColors.myBlack,
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
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
