import 'package:family_tree_application/view/screens/Legacy/legacy.dart';
import 'package:family_tree_application/view/screens/bottom_nav.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
import 'package:family_tree_application/view/screens/home/tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


import '../../../core/constants/colors.dart';
import '../../../core/constants/routes.dart';
import '../../../mock_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PersonListView(),
    Center(
        child: FamilyTreePage()), // Assuming this is a properly defined widget
    const Center(child: Legacy()), // Assuming this is a properly defined widget
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      Get.toNamed(
          AppRoute.userForm); // Make sure you have defined AppRoute.userForm
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar? _buildAppBar(BuildContext context) {
    if (_selectedIndex != 0) return null; // AppBar only for the first page

    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Ajial',
          style: GoogleFonts.lobster(
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0, // Removes the AppBar shadow for a flat design
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.search, color: CustomColors.black, size: 30),
            onPressed: () => showSearch(
                context: context,
                delegate:
                    CustomSearchDelegate()), // Ensure CustomSearchDelegate is defined
          ),
        ),
      ],
    );
  }
}

class PersonListView extends StatelessWidget {
  const PersonListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: MockData.people.length,
        itemBuilder: (context, index) {
          final personKey = 'person${index + 1}';
          final person = MockData.people[personKey];
          return person != null
              ? PersonCard(person: person)
              : SizedBox.shrink();
        },
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final Map<String, dynamic> person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: CustomColors.black.withOpacity(0.5),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(person['image'],
            height: 60, width: 60, fit: BoxFit.cover),
        title: Text(person['name'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text('${person['subject']} - ${person['location']}',
            style: TextStyle(fontSize: 16)),
        trailing: TextButton(
          child: Text('View Family',
              style: TextStyle(color: CustomColors.primaryColor)),
          onPressed: () =>
              Get.toNamed(AppRoute.tree), // Make sure AppRoute.tree is defined
        ),
      ),
    );
  }
}
