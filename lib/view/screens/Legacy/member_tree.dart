import 'package:family_tree_application/controller/add_child_controller.dart';
import 'package:family_tree_application/controller/add_parent_controller%20copy.dart';
import 'package:family_tree_application/controller/child_form_controller.dart';
import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/member_legacy_controller.dart';
import 'package:family_tree_application/controller/spouse_form_controller.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/model/extended_node_model.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
import 'package:family_tree_application/core/constants/routes.dart';

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
  bool isLoading = true; // Add a loading state

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

  void _initializeGraph() {
    graph = Graph(); // Clear the graph to start fresh

    // Initialize the root node using the person's memberId
    final String rootPersonId = childSpouseController.personIdController.text;
    final String rootPersonName =
        "${memberLegacyController.firstName} ${memberLegacyController.family.value.familyName}";
    final ExtendedNode rootNode = ExtendedNode.dualId(rootPersonId);
    graph.addNode(rootNode);
    rootNode.setPrimaryGender(memberLegacyController.gender.value);

    nodeNames[rootPersonId] = [rootPersonName + " (Root)"];
    print("Root node added: Name = $rootPersonName, ID = $rootPersonId");
    initialNodeId = rootPersonId;
    // Expand the graph starting from the root node
    _expandNode(rootNode);
  }

// Recursive function to expand nodes
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
                    ? Center(
                        child:
                            CircularProgressIndicator()) // Show loading indicator while data is loading
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
                      onTap: () async {
                        var marriageIdSelectedNode =
                            (node as ExtendedNode).marriageKey?.value;

                        childController.marriageId.text =
                            marriageIdSelectedNode!;

                        parentController.marriageId.text =
                            marriageIdSelectedNode!;

                        setState(() => selectedNodeId = node.key?.value);

                        print(
                            "selected node when adding child ${selectedNodeId}");
                        childFormController.clearForm();

                        // final result =
                        await Get.toNamed(
                          AppRoute.childForm,
                          // arguments: "child"
                        );

                        // if (result == true) {
                        final firstName =
                            "${childFormController.firstNameController.text} ${childFormController.family}";
                        final newChildId = childFormController.person1Id.text;

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
                        backgroundImage: (node).getSecondaryGender == "Female"
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
                            setState(() => selectedNodeId = node.key?.value);
                            print(
                                "selected node when adding child ${selectedNodeId}");
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

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      CustomBottomSheet(
        children: [
          GestureDetector(
            onTap: () async {
              userFormController.clearForm();

              parentController.childId.text = selectedNodeId!;

              await Get.offNamed(AppRoute.userForm, arguments: "parent");
              // if (result == true) {
              final person1FirstName =
                  "${userFormController.firstNameController.text} ${userFormController.family}";
              final newParent1Id = userFormController.person1Id.text;
              final newMarriageId = parentController.marriageId.text;
              _addParent(person1FirstName, newParent1Id, newMarriageId);
              // }
            },
            child: Image.asset(AppImageAsset.mother),
          ),
          GestureDetector(
            onTap: () async {
              spouseFormController.clearForm();
              // final result =
              marriageFormController.selectedNodeIdPerson1.text =
                  selectedNodeId!;
              await Get.toNamed(AppRoute.spouseForm, arguments: "spouse");
              // if (result == true) {
              final firstName =
                  "${spouseFormController.firstNameController.text} ${spouseFormController.family}";
              final newSpouseId = spouseFormController.person2Id.text;
              final newMarriageId = marriageFormController.marriageIda.text;
              _addSpouse(firstName, newSpouseId, newMarriageId);
              // }
            },
            child: Image.asset(AppImageAsset.couple, height: 50),
          ),
        ],
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
