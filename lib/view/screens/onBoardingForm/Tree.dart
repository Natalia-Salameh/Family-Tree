import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/view/screens/Forms/relative_form.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/add_member.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/view/widgets/form/progress_indicator.dart';

class TreeState extends StatefulWidget {
  const TreeState({Key? key}) : super(key: key);

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<TreeState> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  double _scale = 1.0;
  Map<int, List<String>> nodeNames = {};
  int? selectedNodeId;

  @override
  void initState() {
    super.initState();
    builder
      ..siblingSeparation = 100
      ..levelSeparation = 150
      ..subtreeSeparation = 100
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    _initializeGraph();
  }

  void _initializeGraph() {
    final n.Node rootNode = n.Node.Id(1); // Root node
    graph.addNode(rootNode);
    nodeNames[1] = ["Antoun"];
  }

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<ProgressController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              ProgressBar(progress: progressController.progress.value),
              const SizedBox(height: 20),
              const Text(
                "Click on the add button to start adding your relatives!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 185),
              Expanded(
                child: InteractiveViewer(
                  transformationController: TransformationController()
                    ..value = Matrix4.diagonal3Values(_scale, _scale, 1),
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    builder: (node) => _nodeWidget(node),
                  ),
                ),
              ),
              Button(
                onPressed: () {
                  progressController.updateProgress();
                  Get.offAllNamed(AppRoute.diary);
                },
                color: CustomColors.primaryColor,
                child: const Text("Next",
                    style: TextStyle(color: CustomColors.white)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context),
        child: Icon(Icons.add),
        backgroundColor: CustomColors.primaryColor,
      ),
    );
  }

  Widget _nodeWidget(n.Node node) {
    // This method should be adjusted based on your node widget implementation
    final isSelected = node.key?.value == selectedNodeId;
    final names = nodeNames[node.key?.value] ?? ["Unnamed"];
    return GestureDetector(
      onTap: () => setState(() => selectedNodeId = node.key?.value),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        child: Text(names.join(", "), textAlign: TextAlign.center),
      ),
    );
  }

  void _addChild(String name) {
    if (selectedNodeId == null) return;
    final newChildId = graph.nodeCount() + 1;
    final childNode = n.Node.Id(newChildId);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    setState(() {});
  }

  void _addSpouse(String name) {
    if (selectedNodeId == null) return;
    final currentNames = nodeNames[selectedNodeId];
    if (currentNames != null) {
      currentNames.add(name);
    } else {
      nodeNames[selectedNodeId!] = [name];
    }
    setState(() {});
  }

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      CustomBottomSheet(
        children: [
          GestureDetector(
            onTap: () => _navigateAndAdd('Parent'),
            child: Image.asset(AppImageAsset.mother),
          ),
          GestureDetector(
            onTap: () => _navigateAndAdd('Spouse'),
            child: Image.asset(AppImageAsset.couple, height: 50),
          ),
          GestureDetector(
            onTap: () => _navigateAndAdd('Child'),
            child: Image.asset(AppImageAsset.child),
          ),
        ],
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // void _navigateAndAdd(String role) {
  //   Navigator.pop(context); // Close the bottom sheet
  //   // Navigate to your UserAdd page and pass the role
  //   // Example: Get.toNamed(AppRoute.userAdd, arguments: {"role": role}).then((result) => handleAddNodeResult(result, role));
  //   // Assuming your UserAdd page returns a name, let's simulate receiving the name
  //   final name = "New Name"; // Simulate receiving name from UserAdd
  //   handleAddNodeResult(name, role);
  // }
  void _navigateAndAdd(String role) async {
    Navigator.pop(context); // Close the bottom sheet
    // Await the result from UserAdd screen
    final result = await Get.to(() => UserAdd(role: role));

    if (result != null && result is Map) {
      String role = result['role'];
      String firstName = result['firstName'];
      // Now, add the node based on the role and name returned
      addNode(role, firstName);
    }
  }

  void addNode(String role, String name) {
    // Assuming "Child" results in adding a new node and "Spouse" adds a name to the existing node
    if (role == "Child") {
      _addChild(name);
    } else if (role == "Spouse") {
      _addSpouse(name);
    }
  }

  void handleAddNodeResult(String name, String role) {
    if (role == "Child") {
      _addChild(name);
    } else if (role == "Spouse") {
      _addSpouse(name);
    }
  }
}
