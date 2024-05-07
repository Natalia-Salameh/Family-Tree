
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
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
  final Graph graph = Graph();

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Map<String, List<String>> nodeNames = {};
  List<n.Node> nodes = [];
  String? selectedNodeId;
  Map<String, bool> isSpouseMap = {};

  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  late bool isSpouse;

  @override
  void initState() {
    super.initState();
    builder
      ..siblingSeparation = 50
      ..levelSeparation = 50
      ..subtreeSeparation = 50
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    _initializeGraph();
  }

  void _initializeGraph() {
    final n.Node rootNode = n.Node.Id(userFormController.person1Id.text);
    print(userFormController.person1Id.text);
    graph.addNode(rootNode);
    nodeNames[userFormController.person1Id.text] = [
      "${userFormController.firstNameController.text} ${userFormController.lastNameController.text}"
    ];
    nodes.add(rootNode);
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
                    ..value = Matrix4.diagonal3Values(1, 1, 1),
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(100),
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
    isSpouse = isSpouseMap[node.key?.value] ?? false;
    final nodeWidget = Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 30,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    setState(() => selectedNodeId = node.key?.value);
                    _showBottomSheet(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(names.first),
      ],
    );
    // if (spouse == true) {
    return Container(
      //color: isSpouse ? Colors.cyan : Colors.transparent,
      decoration: isSpouse
          ? BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            )
          : null,
      child: nodeWidget,
    );
    // }
    //  else {
    //   return nodeWidget;
    // }
  }

  void _addSpouse(String name, String newSpouseId) {
    if (selectedNodeId == null) return;
    final newSpouseId = userFormController.person1Id.text;
    final spouseNode = n.Node.Id(newSpouseId);
    graph.addNode(spouseNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), spouseNode,
        paint: Paint()..color = Colors.transparent);
    nodeNames[newSpouseId] = [name];
    isSpouseMap[newSpouseId] = true;
    nodes.add(spouseNode);
    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    //final childNode = n.Node.Id(newChildId);
    final ExtendedNode childNode = ExtendedNode.DualId(newChildId);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    isSpouseMap[newChildId] = false;
    setState(() {});
  }

  void _addParent(String name, String newParentId) {
    if (selectedNodeId == null) return;
    final newParentId = userFormController.person1Id.text;
    final parentNode = n.Node.Id(newParentId);
    graph.addNode(parentNode);
    graph.addEdge(parentNode, graph.getNodeUsingId(selectedNodeId!));
    nodeNames[newParentId] = [name];
    setState(() {});
  }

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      CustomBottomSheet(
        children: [
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();
              await Get.offNamed(AppRoute.userForm, arguments: "parent");
              final firstName = userFormController.firstNameController.text;
              final newParentId = userFormController.person1Id.text;
              _addParent(firstName, newParentId);
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
