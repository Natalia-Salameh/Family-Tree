import 'package:dotted_border/dotted_border.dart';
import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/member_form_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
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

import '../../../classes/showPopOut_addM.dart';

class TreeState extends StatefulWidget {
  const TreeState({Key? key}) : super(key: key);

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<TreeState> {
  final Graph graph = Graph();

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  double _scale = 1.0;
  Map<String, List<String>> nodeNames = {};
  String? selectedNodeId;
  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  String? initialNodeId;
  final SpouseFormController spouseFormController =
      Get.put(SpouseFormController());
  final ChildController childController = Get.put(ChildController());
  final ParentController parentController = Get.put(ParentController());
  final ChildFormController childFormController =
      Get.put(ChildFormController());
  final MemberFormController memberFormController =
      Get.put(MemberFormController());

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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupContentTree();
      },
    );
  }

  void _initializeGraph() {
    final ExtendedNode extendedNode = ExtendedNode.dualId(
        memberFormController.person1Id.text, memberFormController.gender);
    final primaryId = memberFormController.person1Id.text;

    graph.addNode(extendedNode);
    extendedNode.setPrimaryGender(memberFormController.gender);
    String firstAndLastName =
        "${memberFormController.firstNameController.text} ${memberFormController.family}";
    nodeNames[primaryId] = [firstAndLastName];
    initialNodeId = primaryId;
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
                  Get.offAllNamed(AppRoute.diary);
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
    bool isInitialPrimaryNode = node.key?.value == initialNodeId;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          if (names.length > 1) ...[const SizedBox(width: 120)],
          for (var i = 0; i < names.length; i++) ...[
            if (i != 0) ...[
              Container(
                height: 2.5,
                width: 60,
                color: Colors.black,
              ),
            ],
            Column(
              children: [
                Stack(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      color: Color.fromARGB(255, 126, 133, 126),
                      strokeWidth: 1,
                      dashPattern: [5, 5],
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            (node as ExtendedNode).getPrimaryGender == "Female"
                                ? const AssetImage(AppImageAsset.mother)
                                : const AssetImage(AppImageAsset.father),
                      ),
                    ),
                    if (i != 0) ...[
                      DottedBorder(
                        borderType: BorderType.Circle,
                        color: Color.fromARGB(255, 126, 133, 126),
                        strokeWidth: 1,
                        dashPattern: [5, 5],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              (node as ExtendedNode).getSecondaryGender ==
                                      "Female"
                                  ? const AssetImage(AppImageAsset.mother)
                                  : const AssetImage(AppImageAsset.father),
                        ),
                      )
                    ],
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            setState(() => selectedNodeId = node.key?.value);
                            print(
                                "selected node when adding child ${selectedNodeId}");

                            _showBottomSheet(context, node);
                          },
                          child: node.secondaryKey?.value == null ||
                                  isInitialPrimaryNode && i == 0 ||
                                  i == 0
                              ? const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 12,
                                  child: Icon(
                                    Icons.add,
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

  void _addSpouse(String name, String spouseId, String marriageId) {
    if (selectedNodeId == null) return;
    ExtendedNode? node = graph.getNodeUsingId(selectedNodeId) as ExtendedNode;

    node.setSecondaryId(spouseId);
    node.setMarriageId(marriageId);
    node.setSecondaryGender(spouseFormController.gender);
    final names = nodeNames[selectedNodeId];

    names!.add(name);

    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final ExtendedNode childNode =
        ExtendedNode.dualId(newChildId, childFormController.gender);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    setState(() {});
  }

  void _addParent(String name, String newParent1Id, String marriageId) async {
    final ExtendedNode extendedNode =
        ExtendedNode.dualId(newParent1Id, userFormController.gender);
    graph.addNode(extendedNode);
    graph.addEdge(extendedNode, graph.getNodeUsingId(selectedNodeId!));

    extendedNode.setPrimaryGender(userFormController.gender);
    nodeNames[newParent1Id] = [name];

    final firstName =
        "${spouseFormController.firstNameController.text} ${spouseFormController.family}";
    final newParent2Id = spouseFormController.person2Id.text;

    ExtendedNode? node = graph.getNodeUsingId(newParent1Id) as ExtendedNode;

    node.setSecondaryId(newParent2Id);

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
