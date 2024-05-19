import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/home_page_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/model/home_page_model.dart';
import 'package:family_tree_application/view/screens/Forms/user_form.dart';
import 'package:family_tree_application/view/screens/Legacy/member_legacy.dart';
import 'package:family_tree_application/view/screens/home/search.dart';
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
            PersonListView(homeController: homeController),
            Center(child: UserForm()),
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
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());

  PersonCard({Key? key, required this.person}) : super(key: key);

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
            onPressed: () {
              Get.toNamed(AppRoute.userLegacy, arguments: {'id': person.id});
            }),
      ),
    );
  }
}
