import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/search_model.dart';
import 'package:get/get.dart';

class SearchPersonController extends GetxController {
  final listSearch = <String>[].obs;

  void search(String query) async {
    listSearch.clear();
    if (query.isEmpty) {
      print('Query is empty');
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
      print(listSearch);
    } else {
      print('Failed to fetch search results: ${response.statusCode}');
    }
  }
}

