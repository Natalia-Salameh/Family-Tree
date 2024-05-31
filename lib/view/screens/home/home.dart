import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/home_page_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
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

import '../../../classes/showPopOutf_home.dart';

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
      final args = Get.arguments;
      final bool fromSignup = args != null && args['fromSignup'] == true;
      if (fromSignup) {
        _showPopup(context);
      }
    });
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupContent();
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildGreeting(),
                  _buildFeaturedFamily(),
                  _buildPersonListView(),
                ],
              ),
            ),
            GetBuilder<UserFormController>(
              init: UserFormController(),
              dispose: (_) => Get.delete<UserFormController>(),
              builder: (_) => UserForm(),
            ),
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
      title: Text(
        "Ajial",
        style: GoogleFonts.lobster(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
      backgroundColor: CustomColors.myCustomColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 28),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CustomColors.myCustomColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Ajial!",
            style: GoogleFonts.aBeeZee(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Explore your family history and connections.",
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedFamily() {
    List<FeaturedFamily> featuredFamilies = [
      FeaturedFamily(
        familyName: "Al-Shomali Family",
        story: "Contributions to local politics ",
      ),
      FeaturedFamily(
        familyName: "Haddad Family",
        story: "Roots tracing back to the early 1800s.",
      ),
    ];
    Text(
      "People with account",
      style: GoogleFonts.aBeeZee(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 17),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredFamilies.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 200,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    featuredFamilies[index].familyName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    featuredFamilies[index].story,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: homeController.homePageList.length,
            itemBuilder: (context, index) {
              return PersonCard(person: homeController.homePageList[index]);
            },
          ),
        ],
      ),
    );
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

class FeaturedFamily {
  final String familyName;
  final String story;

  FeaturedFamily({
    required this.familyName,
    required this.story,
  });
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
                    person.gender.toString() == "Gender.FEMALE"
                        ? "Female"
                        : "Male",
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 95, 92, 92)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: CustomColors.black),
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
