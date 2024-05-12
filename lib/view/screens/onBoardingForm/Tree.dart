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

  void _initializeGraph() {
    final ExtendedNode extendedNode = ExtendedNode.dualId(
        memberFormController.memberId.text, memberFormController.gender);
    final primaryId = memberFormController.memberId.text;
    print(memberFormController.memberId.text);
    graph.addNode(extendedNode);
    extendedNode.setPrimaryGender(memberFormController.gender);
    String firstAndLastName =
        "${memberFormController.firstNameController.text} ${memberFormController.family}";
    nodeNames[memberFormController.memberId.text] = [firstAndLastName];
    print(firstAndLastName);
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
                child: Text("Next".tr,
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
    print(names);
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
                      onTap: () async {
                        setState(() => selectedNodeId = node.key?.value);
                        userFormController.clearForm();

                        // final result =
                        await Get.toNamed(AppRoute.userForm,
                            arguments: "child");

                        // if (result == true) {
                        final firstName =
                            "${userFormController.firstNameController.text} ${userFormController.family}";
                        final newChildId = userFormController.person1Id.text;

                        _addChild(firstName, newChildId);
                        // }
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
                        backgroundImage:
                            (node as ExtendedNode).getSecondaryGender ==
                                    "Female"
                                ? const AssetImage(AppImageAsset.mother)
                                : const AssetImage(AppImageAsset.father),
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
                            var primaryId = node.key?.value;
                            var secondaryId = node.secondaryKey?.value;
                            print(
                                "Primary ID: $primaryId, Secondary ID: $secondaryId");

                            setState(() => selectedNodeId = primaryId);
                            _showBottomSheet(context);
                          },
                          child: node.secondaryKey?.value == null ||
                                  isInitialPrimaryNode && i == 0
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

  void _addSpouse(String name, String spouseId) {
    if (selectedNodeId == null) return;

    ExtendedNode? node = graph.getNodeUsingId(selectedNodeId) as ExtendedNode;

    node.setSecondaryId(spouseId);
    print(userFormController.gender);
    node.setSecondaryGender(userFormController.gender);
    print(spouseId);
    final names = nodeNames[selectedNodeId];
    if (names != null) {
      names.add(name);
    } else {
      nodeNames[selectedNodeId!] = [name];
    }
    nodeNames[spouseId] = [name];

    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final ExtendedNode childNode =
        ExtendedNode.dualId(newChildId, userFormController.gender);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
    setState(() {});
  }

  void _addParent(String name, String newParent1Id) async {
    final ExtendedNode extendedNode =
        ExtendedNode.dualId(newParent1Id, userFormController.gender);
    graph.addNode(extendedNode);
    graph.addEdge(extendedNode, graph.getNodeUsingId(selectedNodeId!));

    extendedNode.setPrimaryGender(userFormController.gender);
    String firstAndLastName = name;
    nodeNames[newParent1Id] = [firstAndLastName];

    final firstName =
        "${spouseFormController.firstNameController.text} ${spouseFormController.family}";
    final newParent2Id = spouseFormController.person2Id.text;

    ExtendedNode? node = graph.getNodeUsingId(newParent1Id) as ExtendedNode;

    node.setSecondaryId(newParent2Id);
    print(userFormController.gender);
    node.setSecondaryGender(spouseFormController.gender);
    print(newParent2Id);
    final names = nodeNames[newParent1Id];
    print(names);
    print(firstName);
    names!.add(firstName);
    //nodeNames[newParent1Id] = [firstName];

    setState(() {});
  }

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      CustomBottomSheet(
        children: [
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();
              // final result =
              await Get.offNamed(AppRoute.userForm, arguments: "parent");
              // if (result == true) {
              final person1FirstName =
                  "${userFormController.firstNameController.text} ${userFormController.family}";
              final newParent1Id = userFormController.person1Id.text;
              _addParent(person1FirstName, newParent1Id);
              // }
            },
            child: Image.asset(AppImageAsset.mother),
          ),
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();
              // final result =
              await Get.toNamed(AppRoute.userForm, arguments: "spouse");
              // if (result == true) {
              final firstName =
                  "${userFormController.firstNameController.text} ${userFormController.family}";
              final newSpouseId = userFormController.person1Id.text;
              _addSpouse(firstName, newSpouseId);
              // }
            },
            child: Image.asset(AppImageAsset.couple, height: 50),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     userFormController.clearForm();
          //     await Get.toNamed(AppRoute.userForm, arguments: "child");
          //     final firstName =
          //         "${userFormController.firstNameController.text} ${userFormController.family}";
          //     final newChildId = userFormController.person1Id.text;
          //     _addChild(firstName, newChildId);
          //   },
          //   child: Image.asset(AppImageAsset.child),
          // ),
        ],
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
