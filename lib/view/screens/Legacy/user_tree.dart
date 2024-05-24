import 'dart:convert';

import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/controller/user_legacy_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;

class FamilyTreePage extends StatefulWidget {
  const FamilyTreePage({Key? key}) : super(key: key);

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<FamilyTreePage> {
  Graph graph = Graph();

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Map<String, List<String>> nodeNames = {};
  List<n.Node> nodes = [];
  String? selectedNodeId;
  Map<String, bool> isSpouseMap = {};
  double _scale = 1.0;

  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  late bool isSpouse;
  final UserLegacyController userLegacyController =
      Get.put(UserLegacyController());
  bool isLoading = true;

  final SpouseFormController spouseFormController =
      Get.put(SpouseFormController());
  final ChildController childController = Get.put(ChildController());
  final ParentController parentController = Get.put(ParentController());
  final ChildFormController childFormController =
      Get.put(ChildFormController());
  String? initialNodeId;

  @override
  void initState() {
    super.initState();
    childSpouseController.fetchSpouseAndChildren().then((_) {
      _initializeGraph();
      setState(() => isLoading = false);
    });
  }

  void _clearGraph() {
    List<n.Node> nodes = List.from(graph.nodes);
    for (var node in nodes) {
      graph.removeNode(node);
    }
  }

  void _initializeGraph() async {
    graph = Graph();
    final String rootPersonId = childSpouseController.personIdController.text;
    final String rootPersonName =
        "${userLegacyController.firstName} ${userLegacyController.family.familyName}";
    final ExtendedNode rootNode = ExtendedNode.dualId(rootPersonId);

    // Fetch and set root node image
    if (userLegacyController.imageBytes != null) {
      rootNode.setPrimaryImage(userLegacyController.imageBytes);
    }
    graph.addNode(rootNode);
    rootNode.setPrimaryGender(userLegacyController.gender);

    nodeNames[rootPersonId] = [rootPersonName + " (Root)"];
    print("Root node added: Name = $rootPersonName, ID = $rootPersonId");

    _expandNode(rootNode);
  }

  void _expandNode(ExtendedNode node) async {
    var familyDataList =
        await childSpouseController.fetchSpouseAndChildrenById(node.key!.value);
    selectedNodeId = node.key!.value;

    for (var familyData in familyDataList) {
      // Set spouse image if available
      if (familyData.spouse.memberPhoto != null &&
          familyData.spouse.memberPhoto.isNotEmpty) {
        node.setSecondaryImage(base64Decode(familyData.spouse.memberPhoto));
      }

      ExtendedNode? nodee =
          graph.getNodeUsingId(selectedNodeId) as ExtendedNode;
      node.setSecondaryId(nodee);
      node.setMarriageId(familyData.marriageId);

      final spouseName =
          "${familyData.spouse.firstName} ${familyData.spouse.familyName}";
      nodeNames[node.key!.value]!.add(spouseName + " (Spouse)");
      node.setSecondaryGender(familyData.spouse.gender);

      print("Spouse added to the same node: $spouseName");

      for (var child in familyData.children) {
        final childNode = ExtendedNode.dualId(child.memberId);
        graph.addNode(childNode);
        graph.addEdge(node, childNode);
        nodeNames[child.memberId] = ["${child.firstName} ${child.familyName}"];
        print("Child added and connected to node: ${child.firstName}");
        childNode.setPrimaryGender(child.gender);

        // Fetch and set child photo
        if (child.memberPhoto != null && child.memberPhoto.isNotEmpty) {
          childNode.setPrimaryImage(base64Decode(child.memberPhoto));
        }

        _expandNode(childNode);
      }
    }

    if (mounted) {
      setState(() {});
    }
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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InteractiveViewer(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _nodeWidget(n.Node node) {
    final names = nodeNames[node.key?.value] ?? ["Unnamed"];
    bool isInitialPrimaryNode = node.key?.value == initialNodeId;
    final extendedNode = node as ExtendedNode; // Cast node to ExtendedNode

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          for (var i = 0; i < names.length; i++) ...[
            if (i != 0) ...[
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 2.5,
                    width: 60,
                    color: Colors.black,
                  ),
                  Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () async {},
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12,
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: extendedNode.primaryImage != null
                          ? MemoryImage(extendedNode.primaryImage!)
                              as ImageProvider
                          : (extendedNode.getPrimaryGender == "Female"
                              ? const AssetImage(AppImageAsset.mother)
                              : const AssetImage(AppImageAsset.father)),
                    ),
                    if (i != 0) ...[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: extendedNode.secondaryImage != null
                            ? MemoryImage(extendedNode.secondaryImage!)
                                as ImageProvider
                            : (extendedNode.getSecondaryGender == "Female"
                                ? const AssetImage(AppImageAsset.mother)
                                : const AssetImage(AppImageAsset.father)),
                      ),
                    ],
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            setState(
                                () => selectedNodeId = extendedNode.key?.value);
                            print(
                                "selected node when adding child ${selectedNodeId}");
                            //  _showBottomSheet(context);
                          },
                          child: extendedNode.secondaryKey?.value == null ||
                                  isInitialPrimaryNode && i == 0
                              ? const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 12,
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                    )
                  ],
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${names[i].split(' ')[0]} ',
                      style: const TextStyle(color: Colors.black)),
                  TextSpan(
                      text: names[i].split(' ')[1],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ])),
              ],
            ),
          ]
        ]),
      ],
    );
  }
}
