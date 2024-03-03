import 'package:family_tree_application/view/screens/Legacy/legacy.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
import 'package:family_tree_application/view/screens/home/tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/imageasset.dart';
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
  bool _showLegacyPage = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _showLegacyPage = true;
      } else {
        _showLegacyPage = false;
      }
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
              color: Colors.white,
              shadowColor: CustomColors.black,
              elevation: 5,
              margin: EdgeInsets.all(7),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TreeViewPage(),
                            ),
                          );
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
      const Center(child: Text('Add Page')),
      const Center(child: Legacy()),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 231, 231),
      appBar: _showLegacyPage
          ? null
          : AppBar(
              title: Text(
                'Ajial',
                style: GoogleFonts.lobster(
                  textStyle: const TextStyle(
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 232, 231, 231),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
            ),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          if (_showLegacyPage) Legacy(),
        ],
      ),
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
