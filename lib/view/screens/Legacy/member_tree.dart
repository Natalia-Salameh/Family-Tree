import 'package:family_tree_application/controller/get_child_and_spouse_controller.dart';
import 'package:family_tree_application/controller/marriage_form_controller.dart';
import 'package:family_tree_application/controller/member_legacy_controller.dart';
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

  final UserFormController userFormController = Get.put(UserFormController());
  final MarriageFormController marriageFormController =
      Get.put(MarriageFormController());
  final ChildSpouseController childSpouseController =
      Get.put(ChildSpouseController());
  late bool isSpouse;
  final MemberLegacyController memberLegacyController =
      Get.put(MemberLegacyController());
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
    nodeNames[rootPersonId] = [rootPersonName + " (Root)"];
    print("Root node added: Name = $rootPersonName, ID = $rootPersonId");

    // Expand the graph starting from the root node
    _expandNode(rootNode);
  }

// Recursive function to expand nodes
  void _expandNode(ExtendedNode node) async {
    var familyDataList =
        await childSpouseController.fetchSpouseAndChildrenById(node.key!.value);

    for (var familyData in familyDataList) {
      // Process spouse
      final spouseName =
          "${familyData.spouse.firstName} ${familyData.spouse.familyName}";
      nodeNames[node.key!.value]!.add(spouseName + " (Spouse)");
      print("Spouse added to the same node: $spouseName");

      // Add children and connect them to this node
      for (var child in familyData.children) {
        final childNode = ExtendedNode.dualId(child.memberId);
        graph.addNode(childNode);
        graph.addEdge(node, childNode); // Connect each child to the node
        nodeNames[child.memberId] = ["${child.firstName} ${child.familyName}"];
        print("Child added and connected to node: ${child.firstName}");

        // Recursive call to expand the child node
        _expandNode(childNode);
      }
    }

    // Refresh the UI with the new graph
    if (mounted) {
      setState(() {});
    }
  }

  // Future<List<GetSpouseAndChildrenModel>> fetchChildSpouse(
  //     String memberId) async {
  //   var response = await NetworkHandler.getRequest(
  //     AppLink.getChildSpouse, // Adjust endpoint if necessary
  //     includeToken: true,
  //     queryParams: {'memberId': memberId},
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return getSpouseAndChildrenModelFromJson(response.body);
  //   } else {
  //     print(
  //         'Failed to fetch data for memberId $memberId: ${response.statusCode}');
  //     print('Error details: ${response.body}');
  //     return [];
  //   }
  // }

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
                            if (node is ExtendedNode) {
                              var primaryId = node.key?.value;
                              var secondaryId = node.secondaryKey?.value;
                              print(
                                  "Primary ID: $primaryId, Secondary ID: $secondaryId");
                              List<Widget> actions = [];

                              if (secondaryId == null) {
                                setState(() => selectedNodeId = primaryId);
                                _showBottomSheet(context);
                              } else {
                                String? name1 = nodeNames[primaryId]?.first;
                                String? name2 = nodeNames[secondaryId]?.first;
                                actions.add(
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      setState(
                                          () => selectedNodeId = primaryId);
                                      print(selectedNodeId);
                                      _showBottomSheet(context);
                                    },
                                    child: Text(
                                      // "Primary: ${primaryId ?? "ID unavailable"}",
                                      name1 ?? "Unnamed",
                                    ),
                                  ),
                                );

                                if (secondaryId != null) {
                                  actions.add(
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        setState(
                                            () => selectedNodeId = secondaryId);
                                        print(selectedNodeId);
                                        _showBottomSheet(context);
                                      },
                                      child: Text(
                                        // "Spouse: $secondaryId",
                                        name2 ?? "Unnamed",
                                      ),
                                    ),
                                  );
                                }

                                Get.defaultDialog(
                                    title: "Select",
                                    middleText: "Choose a person to add to:",
                                    actions: actions);
                              }
                            }
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

  void _addSpouse(String name, String spouseId) {
    if (selectedNodeId == null) return;

    ExtendedNode? node = graph.getNodeUsingId(selectedNodeId) as ExtendedNode?;

    if (node != null) {
      node.setSecondaryId(spouseId);
      print(spouseId);
      final names = nodeNames[selectedNodeId];
      if (names != null) {
        names.add(name);
      } else {
        nodeNames[selectedNodeId!] = [name];
      }
      nodeNames[spouseId] = [name];
    }
    setState(() {});
  }

  void _addChild(String name, String newChildId) {
    if (selectedNodeId == null) return;
    final ExtendedNode childNode = ExtendedNode.dualId(newChildId);
    graph.addNode(childNode);
    graph.addEdge(graph.getNodeUsingId(selectedNodeId!), childNode);
    nodeNames[newChildId] = [name];
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
              final newSpouseId = userFormController.person1Id.text;
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
