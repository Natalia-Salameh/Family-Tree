import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/view/screens/Forms/spouse_form.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/controller/progress_bar.dart';

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
  final SpouseFormController spouseFormController =
      Get.put(SpouseFormController());
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
    graph.addNode(rootNode);
    nodeNames[userFormController.person1Id.text] = [
      userFormController.firstNameController.text
    ];
  }

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<ProgressController>();

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
                  progressController.updateProgress();
                  Get.offAllNamed(AppRoute.diary);
                },
                color: CustomColors.primaryColor,
                child: Text("58".tr,
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
          for (var i = 0; i < names.length; i++) ...[
            if (i != 0)
              Container(
                height: 2.5,
                width: 20,
                color: Colors.black,
              ),
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
                Text(names[i]),
              ],
            ),
          ]
        ]),
      ],
    );
  }

  // void _addSpouse(String name) {
  //   if (selectedNodeId == null) return;
  //   final currentNames = nodeNames[selectedNodeId];
  //   if (currentNames != null) {
  //     currentNames.add(name);
  //   } else {
  //     nodeNames[selectedNodeId!] = [name];
  //   }
  //   setState(() {});
  // }

  void _addSpouse(name) {
    if (selectedNodeId == null) return;
    final newSpouseId = spouseFormController.person2Id.text;
    final spouseNode = n.Node.Id(newSpouseId);
    graph.addNode(spouseNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), spouseNode);
    setState(() {});
  }

  //   void _addChild(String name) {
  //   if (selectedNodeId == null) return;
  //   final newChildId = graph.nodeCount() + 1;
  //   final childNode = n.Node.Id(newChildId);
  //   graph.addNode(childNode);
  //   graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
  //   nodeNames[newChildId] = [name];
  //   setState(() {});
  // }

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

  void _navigateAndAdd(String role) async {
    Navigator.pop(context);
    final result = await Get.to(() => SpouseForm(role: role));

    print('Result from SpouseForm: $result');

    if (result != null && result is Map) {
      String role = result['role'];
      String firstName = result['firstName'];
      print('Role: $role, firstName: $firstName');
      addNode(role, firstName);
    }
  }

  void addNode(String role, String name) {
    print('addNode called with role: $role, name: $name');
    if (role == "Spouse") {
      _addSpouse(name);
    } else if (role == "Child") {
      // _addChild(name);
    } else if (role == "Parent") {
      // _addParent(name);
    }
  }
}
