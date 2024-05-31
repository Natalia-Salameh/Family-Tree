import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/home_page_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFetchingMore = false.obs;
  RxList<HomePageModel> homePageList = <HomePageModel>[].obs;
  Set<String> memberIDs = {}; // Set to track unique member IDs
  int currentPage = 0;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    fetchHomePageMembers();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isFetchingMore.value) {
        fetchHomePageMembers(isMore: true);
      }
    });
  }

  Future<void> fetchHomePageMembers({bool isMore = false}) async {
    if (isMore) {
      currentPage++;
      isFetchingMore(true);
    } else {
      isLoading(true);
      currentPage = 0; // Reset for fresh loading
      memberIDs.clear(); // Clear previous IDs on refresh
    }

    try {
      final response = await NetworkHandler.getRequest(AppLink.home,
          includeToken: true,
          queryParams: {
            'numOfMembers': '20',
            'page': currentPage.toString(),
          });

      if (response.statusCode == 200) {
        var newMembers = homePageModelFromJson(response.body);
        if (isMore) {
          newMembers = newMembers
              .where((member) => memberIDs.add(member.id))
              .toList(); // Filter out duplicates
          homePageList.addAll(newMembers);
        } else {
          memberIDs.addAll(newMembers.map((m) => m.id));
          homePageList.assignAll(newMembers);
        }
      } else {
        print(
            'Failed to load home page members, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching home page members: $e');
    } finally {
      isLoading(false);
      isFetchingMore(false);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
