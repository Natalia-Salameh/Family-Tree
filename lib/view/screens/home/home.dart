// ignore_for_file: unnecessary_const

import 'package:family_tree_application/classes/featured_fam.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments;
      final bool fromSignup = args != null && args['fromSignup'] == true;
      if (fromSignup) {
        _showPopup(context);
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !homeController.isFetchingMore.value) {
        homeController.fetchHomePageMembers(isMore: true);
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildAppBar(context) : null,
      body: Obx(() {
        if (homeController.isLoading.value &&
            homeController.homePageList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeView(),
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7".tr,
            style: GoogleFonts.lobster(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: CustomColors.myCustomColor,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !homeController.isFetchingMore.value) {
          homeController.fetchHomePageMembers(isMore: true);
          return true;
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildGreeting(),
            FeaturedFamilies(families: featuredFamilies),
            _buildPersonListView(),
            if (homeController.isFetchingMore.value)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: CustomColors.myCustomColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  Widget _buildPersonListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                : CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 248, 241),
                    child: Image.asset(
                      person.gender.toString() == "Gender.FEMALE"
                          ? AppImageAsset.g
                          : AppImageAsset.f,
                    )),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.fullName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    person.gender.toString() == "Gender.FEMALE"
                        ? "31".tr
                        : "32".tr,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 95, 92, 92)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  color: CustomColors.black),
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
