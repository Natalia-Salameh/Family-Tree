import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/search_model.dart';
import 'package:get/get.dart';

class SearchPersonController extends GetxController {
  final listSearch = <String>[].obs;

  void search(String query) async {
    listSearch.clear();
    if (query.isEmpty) {
      // Using GetX to display a localized message
      Get.snackbar(
        "65".tr, // Assuming you have a generic title for error messages
        "query_empty".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    var response = await NetworkHandler.getRequest(
      AppLink.search,
      includeToken: true,
      queryParams: {'searchWord': query},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<SearchModel> searchModel = searchModelFromJson(response.body);
      listSearch.addAll(searchModel.map((model) => model.fullName));
      print(
          listSearch); // Consider replacing with a more user-friendly method if needed
    } else {
      // Localized error message using Get.snackbar
      Get.snackbar(
        "65".tr,
        "search_failed".tr + ": ${response.statusCode}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
