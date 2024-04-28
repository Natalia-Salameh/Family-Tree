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
    print(userFormController.person1Id.text);
    graph.addNode(rootNode);
    nodeNames[userFormController.person1Id.text] = [
      userFormController.firstNameController.text
    ];
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Column(
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
                          print("selected node id :$selectedNodeId");
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
          ),
        ]),
      ],
    );
  }

  void _addSpouse(String name, String newSpouseId) {
    if (selectedNodeId == null) return;
    final spouseNode = n.Node.Id(newSpouseId);
    graph.addNode(spouseNode);
    graph.addEdge(spouseNode, graph.getNodeUsingId(selectedNodeId!),
        paint: Paint()..color = Colors.red);
    nodeNames[newSpouseId] = [name];
    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final childNode = n.Node.Id(newChildId);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    setState(() {});
  }

  // void _addParent(String name) {
  //   if (selectedNodeId == null) return;
  //   final newParentId = graph.nodeCount() + 1;
  //   final parentNode = n.Node.Id(newParentId);
  //   graph.addNode(parentNode);
  //   graph.addEdge(parentNode, graph.getNodeUsingId(selectedNodeId!));
  //   nodeNames[newParentId] = [name];
  //   setState(() {});
  // }

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
              //userFormController.clearForm();
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
              //userFormController.clearForm();
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
