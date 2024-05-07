import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
import '../model/spouse_childeren_tree_model.dart';

class TreeController extends GetxController {
  var trees = <GetTreeModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  TextEditingController memberIdController = TextEditingController();
  Graph familyGraph = Graph();
  // Fetch trees based on member ID
  Future<void> fetchTrees() async {
    if (memberIdController.text.isEmpty) {
      errorMessage.value = "Member ID is required";
      return;
    }
    isLoading(true);
    try {
      final response = await NetworkHandler.getRequest(
          "${AppLink.getspousechild}/${memberIdController.text}",
          includeToken: true);
      if (response.statusCode == 200) {
        trees.value = getTreeModelFromJson(response.body);
      } else {
        errorMessage.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
void buildFamilyGraph() {
    familyGraph = Graph();
    trees.forEach((tree) {
      var spouseNode = n.Node.Id(tree.spouse.memberId);
      familyGraph.addNode(spouseNode);
      tree.children.forEach((child) {
        var childNode = n.Node.Id(child.memberId);
        familyGraph.addEdge(spouseNode, childNode);
        // Additional logic can be added to recursively handle deeper tree levels
      });
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    memberIdController.dispose();
    super.onClose();
  }
}
