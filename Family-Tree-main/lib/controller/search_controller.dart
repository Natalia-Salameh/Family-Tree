import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/search_model.dart';
import 'package:get/get.dart';

class SearchPersonController extends GetxController {
  final listSearch = <SearchModel>[].obs;
  final fullNameResult = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void search(String query) async {
    listSearch.clear();
    if (query.isEmpty) {
      Get.snackbar(
        "65".tr,
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
      listSearch.addAll(searchModel);

      for (var element in searchModel) {
        fullNameResult.value = element.fullName;
        print(element.fullName);
      }
    } else {
      Get.snackbar(
        "65".tr,
        "search_failed".tr + ": ${response.statusCode}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
