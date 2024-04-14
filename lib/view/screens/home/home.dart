import 'package:family_tree_application/controller/home_page_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/mock_data.dart';
import 'package:family_tree_application/model/home_page_model.dart';
import 'package:family_tree_application/view/screens/Legacy/legacy.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
import 'package:family_tree_application/view/screens/home/tree.dart';
import 'package:family_tree_application/view/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final HomeController homeController = Get.put(HomeController());

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
                        child: Text(
                          "38".tr,
                          style:
                              const TextStyle(color: CustomColors.primaryColor),
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
       Center(child: Legacy()),
    ];
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (homeController.isLoading.value &&
            homeController.homePageList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return IndexedStack(
          index: _selectedIndex,
          children: [
            PersonListView(homeController: homeController), // Update this line
            const Center(child: Text("New Page Placeholder")),
             Center(child: Legacy()),
          ],
        );
      }),
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar? _buildAppBar(BuildContext context) {
    if (_selectedIndex != 0) return null; // AppBar only for the first page
    return AppBar(
      title: Text("Ajial", style: GoogleFonts.lobster(fontSize: 30)),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black, size: 30),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PersonListView extends StatelessWidget {
  final HomeController homeController; // Adjusted to pass HomeController

  const PersonListView({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:
          homeController.scrollController, // Attach the scroll controller
      itemCount: homeController.homePageList.length,
      itemBuilder: (context, index) {
        return PersonCard(person: homeController.homePageList[index]);
      },
    );
  }
}

class PersonCard extends StatelessWidget {
  final HomePageModel person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: CustomColors.black.withOpacity(0.5),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: person.memberPhoto != null
            ? Image.network(person.memberPhoto,
                height: 60, width: 60, fit: BoxFit.cover)
            : const Icon(Icons.person, size: 60),
        title: Text(person.fullName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: TextButton(
          child: const Text('View Legacy',
              style: TextStyle(color: CustomColors.primaryColor)),
          onPressed: () =>
              Get.toNamed(AppRoute.tree, arguments: {'userId': person.id}),
        ),
      ),
    );
  }
}
