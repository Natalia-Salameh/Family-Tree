import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/add_update_vote_controller.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/delete_vote_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/get_parent_and_sibling_controller.dart';
import 'package:family_tree_application/controller/get_vote_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
import 'package:family_tree_application/services.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
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
  final ParentSiblingController parentSiblingController =
      Get.put(ParentSiblingController());

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await memberLegacyController.legacyInfo();
    if (childSpouseController.personIdController.text.isNotEmpty) {
      //  await childSpouseController.fetchSpouseAndChildren();
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
    graph = Graph();
    final String rootPersonId = childSpouseController.personIdController.text;
    final String rootPersonName =
        "${memberLegacyController.firstName} ${memberLegacyController.family.value.familyName}";
    final ExtendedNode rootNode = ExtendedNode.dualId(rootPersonId);

    if (memberLegacyController.imageBytes != null) {
      rootNode.setPrimaryImage(memberLegacyController.imageBytes);
    }
    graph.addNode(rootNode);
    rootNode.setPrimaryGender(memberLegacyController.gender.value);
    rootNode.setPrimaryState(memberLegacyController.decision.value);

    nodeNames[rootPersonId] = [rootPersonName + " (Root)"];
    print("Root node added: Name = $rootPersonName, ID = $rootPersonId");
    initialNodeId = rootPersonId;

    _expandChildSpouseNode(rootNode);
    _expandParentSiblingNode(rootNode);
  }

  _expandParentSiblingNode(ExtendedNode node) async {
    var parentDataList =
        await parentSiblingController.fetchParentAndSibling(node.key!.value);

    for (var parentData in parentDataList) {
      if (parentData.parent1.memberPhoto != null &&
          parentData.parent1.memberPhoto.isNotEmpty) {
        node.setPrimaryImage(base64Decode(parentData.parent1.memberPhoto));
      }

      if (parentData.parent2.memberPhoto != null &&
          parentData.parent2.memberPhoto.isNotEmpty) {
        node.setSecondaryImage(base64Decode(parentData.parent2.memberPhoto));
      }
      final ExtendedNode parent1Node =
          ExtendedNode.dualId(parentData.parent1.memberId);

      graph.addNode(parent1Node);
      graph.addEdge(parent1Node, node);

      final parent1Name =
          "${parentData.parent1.firstName} ${parentData.parent1.familyName}";
      nodeNames[parentData.parent1.memberId] = [parent1Name];
      parent1Node.setPrimaryGender(parentData.parent1.gender);
      parent1Node.setPrimaryState(parentData.parent1.decision);

      parent1Node.setSecondaryId(parentData.parent2.memberId);
      parent1Node.setMarriageId(parentData.marriageId);
      parent1Node.setSecondaryGender(parentData.parent2.gender);
      parent1Node.setSecondaryState(parentData.parent2.decision);

      final parent2Name =
          "${parentData.parent2.firstName} ${parentData.parent2.familyName}";
      nodeNames[parentData.parent2.memberId] = [parent2Name];
      final names = nodeNames[parentData.parent1.memberId];
      names!.add(parent2Name);

      for (var sibling in parentData.siblings) {
        final siblingNode = ExtendedNode.dualId(sibling.memberId);
        graph.addNode(siblingNode);
        graph.addEdge(parent1Node, siblingNode);
        nodeNames[sibling.memberId] = [
          "${sibling.firstName} ${sibling.familyName}"
        ];
        siblingNode.setPrimaryGender(sibling.gender);
        siblingNode.setPrimaryState(sibling.decision);

        if (sibling.memberPhoto != null && sibling.memberPhoto.isNotEmpty) {
          siblingNode.setPrimaryImage(base64Decode(sibling.memberPhoto));
        }
        _expandChildSpouseNode(siblingNode);
      }
    }
  }

  void _expandChildSpouseNode(ExtendedNode node) async {
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

        _expandChildSpouseNode(childNode);
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
        Row(
          children: [
            if (names.length > 1) const SizedBox(width: 120),
            for (var i = 0; i < names.length; i++) ...[
              if (i != 0)
                Container(
                  height: 2.5,
                  width: 60,
                  color: Colors.black,
                ),
              Column(
                children: [
                  Stack(
                    children: [
                      if (initialNodeId != node.key?.value || i != 0)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedNodeId = (i == 0)
                                  ? node.key?.value
                                  : node.secondaryKey?.value;
                            });
                            print("Selected node ID: $selectedNodeId");
                            Get.offAllNamed(
                              AppRoute.userLegacy,
                              arguments: {'id': selectedNodeId},
                            );
                          },
                          child: DottedBorder(
                            borderType: BorderType.Circle,
                            color: _getBorderColor(i, extendedNode),
                            strokeWidth: 1,
                            dashPattern: [5, 5],
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  _getBackgroundImage(i, extendedNode),
                            ),
                          ),
                        )
                      else
                        DottedBorder(
                          borderType: BorderType.Circle,
                          color: _getBorderColor(i, extendedNode),
                          strokeWidth: 1,
                          dashPattern: [5, 5],
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                _getBackgroundImage(i, extendedNode),
                          ),
                        ),
                      if (i == 0 && initialNodeId == node.key?.value)
                        _buildPopupMenuButton(node),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${names[i].split(' ')[0]} ',
                          style: const TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: names[i].split(' ')[1],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Color _getBorderColor(int i, ExtendedNode extendedNode) {
    return i == 0
        ? (extendedNode.getPrimaryState == "No_Decision"
            ? const Color.fromARGB(255, 126, 133, 126)
            : Colors.transparent)
        : (extendedNode.getSecondaryState == "No_Decision"
            ? const Color.fromARGB(255, 126, 133, 126)
            : Colors.transparent);
  }

  ImageProvider<Object>? _getBackgroundImage(int i, ExtendedNode extendedNode) {
    if (i == 0) {
      if (extendedNode.primaryImage != null) {
        return MemoryImage(extendedNode.primaryImage!);
      } else {
        return (extendedNode.getPrimaryGender == "Female"
            ? const AssetImage(AppImageAsset.mother)
            : const AssetImage(AppImageAsset.father));
      }
    } else {
      if (extendedNode.secondaryImage != null) {
        return MemoryImage(extendedNode.secondaryImage!);
      } else {
        return (extendedNode.getSecondaryGender == "Female"
            ? const AssetImage(AppImageAsset.mother)
            : const AssetImage(AppImageAsset.father));
      }
    }
  }

  Positioned _buildPopupMenuButton(n.Node node) {
    return Positioned(
      right: -10,
      bottom: -10,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: PopupMenuButton(
          color: Colors.white,
          onSelected: (value) => _handlePopupMenuSelection(value, node),
          itemBuilder: (context) => _buildPopupMenuItems(node),
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 12,
            child: Icon(Icons.more_vert, size: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems(n.Node node) {
    final isApproved =
        approvalService.approvalMap[node.key?.value] == "Confirm";
    final isReported = approvalService.approvalMap[node.key?.value] == "Report";

    return [
      PopupMenuItem(
        value: "Confirm",
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 200,
          color: isApproved
              ? const Color.fromARGB(255, 58, 125, 60)
              : Colors.transparent,
          child: Text(
            isApproved ? "Approved" : "Approve",
            style: TextStyle(color: isApproved ? Colors.white : Colors.black),
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
              ? const Color.fromARGB(255, 239, 27, 27)
              : Colors.transparent,
          child: Text(
            isReported ? "Reported" : "Report",
            style: TextStyle(color: isReported ? Colors.white : Colors.black),
          ),
        ),
      ),
      PopupMenuItem(
        value: "add",
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 200,
          child: const Text("Add Family Member"),
        ),
      ),
    ];
  }

  void _handlePopupMenuSelection(String value, n.Node node) {
    setState(() => selectedNodeId = node.key?.value);
    print("Selected node ID: ${node.key?.value} $selectedNodeId");

    switch (value) {
      case "Confirm":
        _handleConfirmAction();
        break;
      case "Report":
        _handleReportAction();
        break;
      case "add":
        print("Add family member action for node ID ${node.key?.value}");
        _showBottomSheet(context, node);
        break;
    }
  }

  void _handleConfirmAction() {
    addVoteController.memberIdController.text = selectedNodeId!;
    addVoteController.voteController.text = "Confirm";
    addVoteController.reasonController.text = "No_Reason";

    if (approvalService.approvalMap[selectedNodeId!] == "Confirm") {
      deleteVoteController.voteId = getVoteController.id;
      deleteVoteController.deleteVote();
      approvalService.saveApproval(selectedNodeId!, "");
    } else {
      addVoteController.addVote();
      approvalService.saveApproval(selectedNodeId!, "Confirm");
    }
  }

  void _handleReportAction() {
    addVoteController.memberIdController.text = selectedNodeId!;
    addVoteController.voteController.text = "Report";
    addVoteController.reasonController.text = "No_Reason";

    if (approvalService.approvalMap[selectedNodeId!] == "Report") {
      deleteVoteController.voteId = getVoteController.id;
      deleteVoteController.deleteVote();
      approvalService.saveApproval(selectedNodeId!, "");
    } else {
      addVoteController.addVote();
      approvalService.saveApproval(selectedNodeId!, "Report");
    }
  }

  void _addSpouse(String name, String spouseId, String marriageId) {
    if (selectedNodeId == null) return;
    ExtendedNode? node = graph.getNodeUsingId(selectedNodeId) as ExtendedNode;

    node.setSecondaryId(spouseId);
    node.setMarriageId(marriageId);
    node.setSecondaryGender(spouseFormController.gender);
    final names = nodeNames[selectedNodeId];

    names!.add(name);

    node.setSecondaryState('No_Decision');

    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final ExtendedNode childNode =
        ExtendedNode.dualId(newChildId, childFormController.gender);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    childNode.setPrimaryState('No_Decision');

    setState(() {});
  }

  void _addParent(String name, String newParent1Id, String marriageId) async {
    final ExtendedNode extendedNode =
        ExtendedNode.dualId(newParent1Id, userFormController.gender);
    graph.addNode(extendedNode);
    graph.addEdge(extendedNode, graph.getNodeUsingId(selectedNodeId!));

    extendedNode.setPrimaryGender(userFormController.gender);
    extendedNode.setPrimaryState('No_Decision');
    nodeNames[newParent1Id] = [name];

    final firstName =
        "${spouseFormController.firstNameController.text} ${spouseFormController.family}";
    final newParent2Id = spouseFormController.person2Id.text;

    ExtendedNode? node = graph.getNodeUsingId(newParent1Id) as ExtendedNode;

    node.setSecondaryId(newParent2Id);

    node.setSecondaryState('No_Decision');

    node.setMarriageId(marriageId);

    node.setSecondaryGender(spouseFormController.gender);

    final names = nodeNames[newParent1Id];

    names!.add(firstName);

    setState(() {});
  }

  void _showBottomSheet(BuildContext context, n.Node node) {
    bool hasParents =
        graph.getInEdges(graph.getNodeUsingId(selectedNodeId!)).isNotEmpty;
    bool hasSpouse = (node as ExtendedNode).secondaryKey != null;

    List<Widget> options = [];
    List<String> optionTexts = [];

    if (!hasParents) {
      options.add(GestureDetector(
        onTap: () async {
          userFormController.clearForm();
          parentController.childId.text = selectedNodeId!;

          final result =
              await Get.offNamed(AppRoute.userForm, arguments: "parent");
          if (result == "true") {
            final person1FirstName =
                "${userFormController.firstNameController.text} ${userFormController.family}";
            final newParent1Id = userFormController.person1Id.text;
            final newMarriageId = parentController.marriageId.text;
            _addParent(person1FirstName, newParent1Id, newMarriageId);
          }
        },
        child: Image.asset(AppImageAsset.mother),
      ));
      optionTexts.add("Add Parents".tr);
    }

    options.add(GestureDetector(
      onTap: () async {
        spouseFormController.clearForm();
        marriageFormController.selectedNodeIdPerson1.text = selectedNodeId!;
        final result =
            await Get.toNamed(AppRoute.spouseForm, arguments: "spouse");
        if (result == 'true') {
          final firstName =
              "${spouseFormController.firstNameController.text} ${spouseFormController.family}";
          final newSpouseId = spouseFormController.person2Id.text;
          final newMarriageId = marriageFormController.marriageIda.text;
          _addSpouse(firstName, newSpouseId, newMarriageId);
        }
      },
      child: Image.asset(AppImageAsset.couple, height: 50),
    ));
    optionTexts.add("Add Spouse".tr);

    if (hasSpouse) {
      options.add(GestureDetector(
        onTap: () async {
          var marriageIdSelectedNode =
              (node as ExtendedNode).marriageKey?.value;

          childController.marriageId.text = marriageIdSelectedNode!;

          parentController.marriageId.text = marriageIdSelectedNode!;

          print("selected node when adding child ${selectedNodeId}");
          childFormController.clearForm();

          final result = await Get.toNamed(AppRoute.childForm);

          if (result == "true") {
            final firstName =
                "${childFormController.firstNameController.text} ${childFormController.family}";
            final newChildId = childFormController.person1Id.text;

            _addChild(firstName, newChildId);
          }
        },
        child: Image.asset(AppImageAsset.child, height: 50),
      ));
      optionTexts.add("Add Child".tr);
    }

    Get.bottomSheet(
      CustomBottomSheet(
        children: options,
        imageTexts: optionTexts,
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
