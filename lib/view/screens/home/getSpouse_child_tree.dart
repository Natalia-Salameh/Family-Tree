// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as n;
// import '../../../controller/spouse_children_tree_controller.dart';
// import '../../../model/spouse_childeren_tree_model.dart';

// class ViewFamilyTree extends StatefulWidget {
//   final String memberId;

//   ViewFamilyTree({Key? key, required this.memberId}) : super(key: key);

//   @override
//   _ViewFamilyTreeState createState() => _ViewFamilyTreeState();
// }

// class _ViewFamilyTreeState extends State<ViewFamilyTree> {
//   final TreeController treeController = Get.put(TreeController());
//   final Graph graph = Graph();

//   @override
//   void initState() {
//     super.initState();
//     treeController.memberIdController.text = widget.memberId;
//     treeController.fetchTrees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Family Tree'),
//       ),
//       body: Obx(() {
//         if (treeController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (treeController.trees.isEmpty) {
//           return Center(
//               child: Text('No data found for the provided Member ID'));
//         }

//         // Populate the graph with nodes and edges

//         treeController.trees.forEach((tree) {
//           buildGraphNodes(graph, tree.spouse, tree.children, null);
//         });

//         return Column(
//           children: [
//             Expanded(
//               child: InteractiveViewer(
//                 constrained: false,
//                 boundaryMargin: EdgeInsets.all(100),
//                 minScale: 0.01,
//                 maxScale: 5.6,
//                 child: GraphView(
//                   graph: graph,
//                   algorithm: BuchheimWalkerAlgorithm(
//                     BuchheimWalkerConfiguration()
//                       ..siblingSeparation = 100
//                       ..levelSeparation = 150
//                       ..subtreeSeparation = 150
//                       ..orientation =
//                           BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
//                   ),
//                   paint: Paint()
//                     ..color = Colors.blue
//                     ..strokeWidth = 1
//                     ..style = PaintingStyle.stroke,
//                   builder: (n.Node node) {
//                     Spouse nodeData = node.key!.value;
//                     return rectangleWidget(
//                         nodeData.firstName, nodeData.memberId);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   // Recursive function to build graph nodes
//   void buildGraphNodes(
//       Graph graph, Spouse spouse, List<Spouse> children, n.Node? parentNode) {
//     var currentNode = n.Node.Id(spouse.memberId);
//     graph.addNode(currentNode);
//     if (parentNode != null) {
//       graph.addEdge(parentNode, currentNode);
//     }
//     children.forEach((child) {
//       buildGraphNodes(graph, child, [], currentNode);
//     });
//   }

//   Widget rectangleWidget(String name, String id) {
//     return InkWell(
//       onTap: () {
//         // Implement action on tap if needed
//         print('Node tapped: $id');
//       },
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.lightBlueAccent,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(name),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:get/get.dart';

import '../../../controller/spouse_children_tree_controller.dart';

class FamilyTreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TreeController treeController = Get.put(TreeController());

    return FutureBuilder(
      future: treeController.fetchTrees(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: GraphView(
                  graph: treeController.familyGraph,
                  algorithm: SugiyamaAlgorithm(SugiyamaConfiguration()
                    ..nodeSeparation = 20
                    ..levelSeparation = 50),
                  paint: Paint()
                    ..color = const Color.fromARGB(255, 48, 49, 97)
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (n.Node node) {
                    var memberId = node.key?.value as String;
                    var member = treeController.trees
                        .firstWhere((tree) => tree.spouse.memberId == memberId);

                    return rectangleWidget(
                        member?.spouse?.firstName ?? "N/A", memberId, 2);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget rectangleWidget(String name, String id, int gender) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(name),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
