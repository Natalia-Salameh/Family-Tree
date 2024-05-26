import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/add_update_vote_controller.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/delete_vote_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/get_vote_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
import 'package:family_tree_application/services.dart';
import 'package:family_tree_application/view/screens/Legacy/user_legacy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;

class MemberFamilyTreePage extends StatefulWidget {
  const MemberFamilyTreePage({Key? key}) : super(key: key);

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<MemberFamilyTreePage> {
  Graph graph = Graph();

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Map<String, List<String>> nodeNames = {};
  List<n.Node> nodes = [];
  String? selectedNodeId;
  Map<String, bool> isSpouseMap = {};
  double _scale = 1.0;
  String? initialNodeId;
  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  late bool isSpouse;
  final MemberLegacyController memberLegacyController =
      Get.put(MemberLegacyController());
  final SpouseFormController spouseFormController =
      Get.put(SpouseFormController());
  final ChildController childController = Get.put(ChildController());
  final ParentController parentController = Get.put(ParentController());
  final ChildFormController childFormController =
      Get.put(ChildFormController());
  bool isLoading = true;
  final AddVoteController addVoteController = Get.put(AddVoteController());
  final GetVoteController getVoteController = Get.put(GetVoteController());
  final DeleteVoteController deleteVoteController =
      Get.put(DeleteVoteController());

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await memberLegacyController.legacyInfo();
    if (childSpouseController.personIdController.text.isNotEmpty) {
      await childSpouseController.fetchSpouseAndChildren();
      _initializeGraph();
    } else {
      print('Error: personIdController is empty.');
    }
    setState(() => isLoading = false);
  }

  void _clearGraph() {
    List<n.Node> nodes = List.from(graph.nodes);
    for (var node in nodes) {
      graph.removeNode(node);
    }
  }

  void _initializeGraph() async {
    graph = Graph(); // Clear the graph to start fresh

    // Initialize the root node using the person's memberId
    final String rootPersonId = childSpouseController.personIdController.text;
    final String rootPersonName =
        "${memberLegacyController.firstName} ${memberLegacyController.family.value.familyName}";
    final ExtendedNode rootNode = ExtendedNode.dualId(rootPersonId);

    // Fetch and set root node image
    if (memberLegacyController.imageBytes != null) {
      rootNode.setPrimaryImage(memberLegacyController.imageBytes);
    }
    graph.addNode(rootNode);
    rootNode.setPrimaryGender(memberLegacyController.gender.value);
    rootNode.setPrimaryState(memberLegacyController.decision.value);

    nodeNames[rootPersonId] = [rootPersonName + " (Root)"];
    print("Root node added: Name = $rootPersonName, ID = $rootPersonId");
    initialNodeId = rootPersonId;

    // Expand the graph starting from the root node
    _expandNode(rootNode);
  }

  void _expandNode(ExtendedNode node) async {
    var familyDataList =
        await childSpouseController.fetchSpouseAndChildrenById(node.key!.value);

    for (var familyData in familyDataList) {
      if (familyData.spouse.memberPhoto != null &&
          familyData.spouse.memberPhoto.isNotEmpty) {
        node.setSecondaryImage(base64Decode(familyData.spouse.memberPhoto));
      }

      final ExtendedNode spouseNode =
          graph.getNodeUsingId(node.key!.value) as ExtendedNode;
      spouseNode.setSecondaryId(familyData.spouse.memberId);
      spouseNode.setMarriageId(familyData.marriageId);
      print(spouseNode);

      final spouseName =
          "${familyData.spouse.firstName} ${familyData.spouse.familyName}";
      nodeNames[node.key!.value]!.add(spouseName + " (Spouse)");
      spouseNode.setSecondaryGender(familyData.spouse.gender);
      spouseNode.setSecondaryState(familyData.spouse.decision);
      print(familyData.spouse.decision);
      print("Spouse added to the same node: $spouseName");

      for (var child in familyData.children) {
        final childNode = ExtendedNode.dualId(child.memberId);
        graph.addNode(childNode);
        graph.addEdge(node, childNode);
        nodeNames[child.memberId] = ["${child.firstName} ${child.familyName}"];
        print("Child added and connected to node: ${child.firstName}");
        childNode.setPrimaryGender(child.gender);
        childNode.setPrimaryState(child.decision);

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
    final extendedNode = node as ExtendedNode;
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
                ],
              ),
            ],
            Column(
              children: [
                Stack(
                  children: [
                    if (initialNodeId != node.key?.value || i != 0)
                      GestureDetector(
                        onTap: () {
                          if (i == 0) {
                            setState(() => selectedNodeId = node.key?.value);
                          } else {
                            setState(() =>
                                selectedNodeId = node.secondaryKey?.value);
                          }
                          print("Selected node ID: ${selectedNodeId}");
                          Get.offAllNamed(
                            AppRoute.userLegacy,
                            arguments: {'id': selectedNodeId},
                          );
                        },
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          color: i == 0
                              ? (extendedNode.getPrimaryState == "No_Decision"
                                  ? Color.fromARGB(255, 126, 133, 126)
                                  : Colors.transparent)
                              : (extendedNode.getSecondaryState == "No_Decision"
                                  ? Color.fromARGB(255, 126, 133, 126)
                                  : Colors.transparent),
                          strokeWidth: 1,
                          dashPattern: [5, 5],
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: i == 0
                                ? (extendedNode.primaryImage != null
                                    ? MemoryImage(extendedNode.primaryImage!)
                                        as ImageProvider<Object>?
                                    : (extendedNode.getPrimaryGender == "Female"
                                        ? const AssetImage(AppImageAsset.mother)
                                            as ImageProvider<Object>?
                                        : const AssetImage(AppImageAsset.father)
                                            as ImageProvider<Object>?))
                                : (extendedNode.secondaryImage != null
                                    ? MemoryImage(extendedNode.secondaryImage!)
                                        as ImageProvider<Object>?
                                    : (extendedNode.getSecondaryGender ==
                                            "Female"
                                        ? const AssetImage(AppImageAsset.mother)
                                            as ImageProvider<Object>?
                                        : const AssetImage(AppImageAsset.father)
                                            as ImageProvider<Object>?)),
                          ),
                        ),
                      )
                    else
                      DottedBorder(
                        borderType: BorderType.Circle,
                        color: i == 0
                            ? (extendedNode.getPrimaryState == "No_Decision"
                                ? Color.fromARGB(255, 126, 133, 126)
                                : Colors.transparent)
                            : (extendedNode.getSecondaryState == "No_Decision"
                                ? Color.fromARGB(255, 126, 133, 126)
                                : Colors.transparent),
                        strokeWidth: 1,
                        dashPattern: [5, 5],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: i == 0
                              ? (extendedNode.primaryImage != null
                                  ? MemoryImage(extendedNode.primaryImage!)
                                      as ImageProvider<Object>?
                                  : (extendedNode.getPrimaryGender == "Female"
                                      ? const AssetImage(AppImageAsset.mother)
                                          as ImageProvider<Object>?
                                      : const AssetImage(AppImageAsset.father)
                                          as ImageProvider<Object>?))
                              : (extendedNode.secondaryImage != null
                                  ? MemoryImage(extendedNode.secondaryImage!)
                                      as ImageProvider<Object>?
                                  : (extendedNode.getSecondaryGender == "Female"
                                      ? const AssetImage(AppImageAsset.mother)
                                          as ImageProvider<Object>?
                                      : const AssetImage(AppImageAsset.father)
                                          as ImageProvider<Object>?)),
                        ),
                      ),
                    if (i == 0 && initialNodeId == node.key?.value) ...[
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Material(
                          color: Colors.transparent,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: PopupMenuButton(
                            color: Colors.white,
                            onSelected: (value) {
                              setState(() => selectedNodeId = node.key?.value);
                              print(
                                  "Selected node ID: ${node.key?.value} $selectedNodeId");
                              if (value == "Confirm") {
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
                                PopupMenuItem(
                                  value: "Confirm",
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 200,
                                    color: isApproved
                                        ? Color.fromARGB(255, 58, 125, 60)
                                        : Colors.transparent,
                                    child: Text(
                                      isApproved ? "Approved" : "Approve",
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
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 200,
                                    color: isReported
                                        ? Color.fromARGB(255, 239, 27, 27)
                                        : Colors.transparent,
                                    child: Text(
                                      isReported ? "Reported" : "Report",
                                      style: TextStyle(
                                          color: isReported
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "add",
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 200,
                                    child: Text("Add Family Member"),
                                  ),
                                ),
                              ];
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(Icons.more_vert,
                                  size: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
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
            )
          ],
        ]),
      ],
    );
  }
}
