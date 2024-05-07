import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/button.dart';

class AddTree extends StatefulWidget {
  const AddTree({Key? key}) : super(key: key);

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<AddTree> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  double _scale = 1.0;
  Map<String, List<String>> nodeNames = {};
  String? selectedNodeId;
  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  Map<String, String> spouses = {};
  bool useAutomaticLayout = true;

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
    final n.Node rootNode = n.Node.Id(userFormController.person1Id.text);
    graph.addNode(rootNode);
    nodeNames[userFormController.person1Id.text] = [
      userFormController.firstNameController.text
    ];
    setState(() {}); // Ensures the graph updates after initialization.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: InteractiveViewer(
                  transformationController: TransformationController()
                    ..value = Matrix4.diagonal3Values(_scale, _scale, 1),
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    builder: (n.Node node) => _nodeWidget(node),
                    paint: (Paint()
                      ..color = Colors.black
                      ..strokeWidth = 1.0
                      ..style = PaintingStyle.stroke),
                  ),
                ),
              ),
              Button(
                onPressed: () {
                  Get.offAllNamed(AppRoute.home);
                },
                color: CustomColors.primaryColor,
                child: Text("Add".tr,
                    style: const TextStyle(color: CustomColors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nodeWidget(n.Node node) {
    final names = nodeNames[node.key?.value] ?? ["Unnamed"];
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNodeId = node.key?.value;
          _showBottomSheet(context);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(radius: 30),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12,
                          child: Icon(Icons.add, size: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Text(names.first),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addSpouse(String name, String newSpouseId) {
    if (selectedNodeId == null) return;

    final n.Node spouseNode = n.Node.Id((graph.nodeCount() + 1).toString());
    graph.addNode(spouseNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), spouseNode,
        paint: Paint()
          ..color = Colors.red
          ..strokeWidth = 3);

    nodeNames[spouseNode.key?.value] = [name];
    spouses[selectedNodeId!] = spouseNode.key?.value;

    n.Node? selectedNode = graph.getNodeUsingId(selectedNodeId);
    if (selectedNode != null) {
      double x = selectedNode.position.dx;
      double y = selectedNode.position.dy;
      spouseNode.position = Offset(x + 150, y); // Adjust as needed
    }

    useAutomaticLayout = false;
    setState(() {}); // Force the graph to update and redraw
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final n.Node childNode = n.Node.Id((graph.nodeCount() + 1).toString());
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[childNode.key?.value] = [name];
    useAutomaticLayout = true;
    setState(() {}); // Update the state to reflect changes in the graph
  }

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      CustomBottomSheet(
        children: [
          GestureDetector(
            onTap: () {
              Get.offNamed(AppRoute.userForm);
            },
            child: Image.asset(AppImageAsset.mother),
          ),
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();
              await Get.toNamed(AppRoute.userForm, arguments: "spouse");
              final firstName = userFormController.firstNameController.text;
              final newSpouseId = userFormController.person2Id.text;
              _addSpouse(firstName, newSpouseId);
            },
            child: Image.asset(AppImageAsset.couple, height: 50),
          ),
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();
              await Get.toNamed(AppRoute.userForm, arguments: "child");
              final firstName = userFormController.firstNameController.text;
              final newChildId = userFormController.person1Id.text;
              _addChild(firstName, newChildId);
            },
            child: Image.asset(AppImageAsset.child),
          ),
        ],
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}

class NoOpLayoutAlgorithm extends Algorithm {
  @override
  Size run(Graph? graph, double width, double height) {
    // Since this algorithm is supposed to do nothing, it returns zero size.
    // However, you should return a reasonable default size if necessary.
    return Size.zero;
  }

  @override
  void init(Graph? graph) {
    // TODO: implement init
  }

  @override
  void setDimensions(double width, double height) {
    // TODO: implement setDimensions
  }

  @override
  void setFocusedNode(n.Node node) {
    // TODO: implement setFocusedNode
  }

  @override
  void step(Graph? graph) {
    // TODO: implement step
  }
}
