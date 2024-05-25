import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/home_page_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSignupFlag();
    });
  }

  void _checkSignupFlag() {
    final args = Get.arguments;
    if (args != null && args['fromSignup'] == true) {
      _showPopup(context);
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome to Ajial!"),
          content: Text(
              "You can press the arrow next to a user to view their legacy and family tree."),
          actions: <Widget>[
            TextButton(
              child: Text("Got it"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildAppBar(context) : null,
      body: Obx(() {
        if (homeController.isLoading.value &&
            homeController.homePageList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return IndexedStack(
          index: _selectedIndex,
          children: [
            PersonListView(homeController: homeController),
            UserForm(),
            Legacy(),
          ],
        );
      }),
      bottomNavigationBar: CustomFloatingBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImageAsset.logo,
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              "Ajial",
              style: GoogleFonts.lobster(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 28),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
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
  final HomeController homeController;

  const PersonListView({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: homeController.scrollController,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            person.photoBytes != null
                ? ClipOval(
                    child: Image.memory(
                      person.photoBytes!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(Icons.person,
                    size: 60, color: Color.fromARGB(255, 78, 76, 76)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.fullName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    person.fullName,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 95, 92, 92)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color: CustomColors.primaryColor),
              onPressed: () {
                Get.toNamed(AppRoute.userLegacy, arguments: {'id': person.id});
              },
            ),
          ],
        ),
      ),
    );
  }
}
