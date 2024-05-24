import 'dart:ui';

import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/add_update_vote_controller.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/delete_vote_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/get_vote_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/controller/user_legacy_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
import 'package:family_tree_application/services.dart';
import 'package:family_tree_application/view/screens/Legacy/user_legacy.dart';
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
  final AddVoteController addVoteController = Get.put(AddVoteController());
  final GetVoteController getVoteController = Get.put(GetVoteController());
  final DeleteVoteController deleteVoteController =
      Get.put(DeleteVoteController());

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

  void _initializeGraph() {
    graph = Graph();
    final String rootPersonId = childSpouseController.personIdController.text;
    final String rootPersonName =
        "${userLegacyController.firstName} ${userLegacyController.family.familyName}";
    final ExtendedNode rootNode = ExtendedNode.dualId(rootPersonId);
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
                          Icons.add,
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
                      backgroundImage:
                          (node as ExtendedNode).getPrimaryGender == "Female"
                              ? const AssetImage(AppImageAsset.mother)
                              : const AssetImage(AppImageAsset.father),
                    ),
                    if (i != 0) ...[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: (node).getSecondaryGender == "Female"
                            ? const AssetImage(AppImageAsset.mother)
                            : const AssetImage(AppImageAsset.father),
                      ),
                    ],
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Material(
                          color: Colors.transparent,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: PopupMenuButton(
                            onSelected: (value) {
                              setState(() => selectedNodeId = node.key?.value);
                              print(
                                  "Selected node ID: ${node.key?.value} $selectedNodeId");
                              if (value == "View Legacy") {
                                Get.offAll(
                                  () => UserLegacy(),
                                  arguments: {'id': selectedNodeId},
                                );
                              } else if (value == "Confirm") {
                                addVoteController.memberIdController.text =
                                    selectedNodeId!;
                                addVoteController.voteController.text =
                                    "Confirm";
                                addVoteController.reasonController.text =
                                    "No_Reason";

                                if (approvalService
                                        .approvalMap[selectedNodeId!] ==
                                    "Confirm") {
                                  deleteVoteController.voteId =
                                      getVoteController.id;
                                  deleteVoteController.deleteVote();
                                  approvalService.saveApproval(
                                      selectedNodeId!, "");
                                } else {
                                  addVoteController.addVote();

                                  approvalService.saveApproval(
                                      selectedNodeId!, "Confirm");
                                }

                                print(
                                    "Approve action for node ID ${node.key?.value}");
                              } else if (value == "Report") {
                                addVoteController.memberIdController.text =
                                    selectedNodeId!;
                                addVoteController.voteController.text =
                                    "Report";
                                addVoteController.reasonController.text =
                                    "No_Reason";
                                if (approvalService
                                        .approvalMap[selectedNodeId!] ==
                                    "Report") {
                                  deleteVoteController.voteId =
                                      getVoteController.id;
                                  deleteVoteController.deleteVote();
                                  approvalService.saveApproval(
                                      selectedNodeId!, "");
                                } else {
                                  addVoteController.addVote();

                                  approvalService.saveApproval(
                                      selectedNodeId!, "Report");
                                }

                                print(
                                    "Report action for node ID ${node.key?.value}");
                              } else if (value == "add") {
                                print(
                                    "Add family member action for node ID ${node.key?.value}");
                              }
                            },
                            itemBuilder: (context) {
                              final isApproved = approvalService
                                      .approvalMap[node.key?.value] ==
                                  "Confirm";

                              final isReported = approvalService
                                      .approvalMap[node.key?.value] ==
                                  "Report";

                              return [
                                const PopupMenuItem(
                                  value: "View Legacy",
                                  child: Text("View Legacy"),
                                ),
                                PopupMenuItem(
                                  value: "Confirm",
                                  child: Container(
                                    color: isApproved
                                        ? Color.fromARGB(255, 58, 125, 60)
                                        : Colors.white,
                                    child: Text(
                                      "Approve",
                                      style: TextStyle(
                                          color: isApproved
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Report",
                                  child: Container(
                                    color: isReported
                                        ? Color.fromARGB(255, 239, 27, 27)
                                        : Colors.white,
                                    child: Text(
                                      "Report",
                                      style: TextStyle(
                                          color: isReported
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "add",
                                  child: Text("Add Family Member"),
                                ),
                              ];
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(Icons.more_vert,
                                  size: 20, color: Colors.black),
                            ),
                          )),
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
