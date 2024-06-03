// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:graphview/GraphView.dart';

// class FamilyTreeController extends GetxController {
//   final Graph graph = Graph()..isTree = true;
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
//   Map<int, List<String>> nodeNames = {}; // Holds node names, key is node ID
//   int? selectedNodeId;

//   @override
//   void onInit() {
//     super.onInit();
//     builder
//       ..siblingSeparation = 100
//       ..levelSeparation = 150
//       ..subtreeSeparation = 100
//       ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
//     _initializeGraph();
//   }

//   void _initializeGraph() {
//     // Initialize graph with the 'Antoun' node as an example
//     final Node parentNode = Node.Id(1);
//     graph.addNode(parentNode);
//     nodeNames[1] = ['Antoun']; // 'Antoun' as the first node
//     selectedNodeId = 1; // Default selected node
//     update(); // Update the UI
//   }

//   void selectNode(int nodeId) {
//     selectedNodeId = nodeId;
//     update(); // Update the UI to reflect the selected node
//   }

//   void addNode(String name, bool isAddingChild) {
//     if (selectedNodeId == null) {
//       // If no node is selected, show an error or handle appropriately
//       return;
//     }

//     if (isAddingChild) {
//       addChild(name);
//     } else {
//       addSpouse(name);
//     }
//   }

//   void addChild(String name) {
//     int newChildId = graph.nodeCount() + 1;
//     Node childNode = Node.Id(newChildId);
//     graph.addNode(childNode);
//     Node? parentNode = graph.getNodeUsingId(selectedNodeId!);

//     if (parentNode != null) {
//       graph.addEdge(parentNode, childNode);
//       nodeNames[newChildId] = [name];
//     }
//     update(); // Notify listeners to update the UI
//   }

//   void addSpouse(String name) {
//     List<String>? currentNames = nodeNames[selectedNodeId];

//     if (currentNames != null && currentNames.isNotEmpty) {
//       currentNames.add(name);
//     } else {
//       currentNames = [name];
//     }

//     nodeNames[selectedNodeId!] = currentNames;
//     update(); // Notify listeners to update the UI
//   }

//   // The methods _createParentNode, _createChildNode, and _parentText
//   // will remain in the UI layer and will use the controller for data.

//   // The method _showAddNodeDialog should be converted to a UI action
//   // that calls addNode in the controller with the name from the dialog.
// }
