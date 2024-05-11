import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/search_controller.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  final SearchPersonController searchController =
      Get.put(SearchPersonController());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
            fontSize: 16.0, color: Color.fromARGB(153, 148, 148, 148)),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      var searchList = searchController.listSearch;
      return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          var result = searchList[index].fullName;
          return ListTile(
            title: Text(result),
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length >= 3) {
      searchController.search(query);
    }

    return Obx(() {
      return ListView.builder(
        itemCount: searchController.listSearch.length,
        itemBuilder: (context, index) {
          var suggestion = searchController.listSearch[index];
          print("$index + ${suggestion.id}");
          return ListTile(
            title: Text(suggestion.fullName),
            onTap: () {
              childSpouseController.personIdController.text = suggestion.id;
              Get.toNamed(AppRoute.userLegacy,
                  arguments: {'id': suggestion.id});
            },
          );
        },
      );
    });
  }
}
