import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class Tree {
  final Graph graph = Graph()..isTree = true;

  Tree() {
    // Define parent nodes
    final Node parentNode1 = Node.Id('Parent1');
    final Node parentNode2 = Node.Id('Parent2');

    // Define children nodes
    final Node childNode1 = Node.Id('Child1');
    final Node childNode2 = Node.Id('Child2');
    final Node childNode3 = Node.Id('Child3');
    final Node childNode4 = Node.Id('Child4');

    // Connect Parent1 to Child1 and Child2
    graph.addEdge(parentNode1, childNode1);
    graph.addEdge(parentNode1, childNode2);

    // Connect Parent2 to Child3 and Child4
    graph.addEdge(parentNode2, childNode3);
    graph.addEdge(parentNode2, childNode4);
  }
  Widget buildView(BuildContext context) {
    BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration()
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM
      ..siblingSeparation = 150
      ..levelSeparation = 150
      ..subtreeSeparation = 150;

    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: Center(
        // Wrap the GraphView in a Center widget
        child: GraphView(
          graph: graph,
          algorithm:
              BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
          builder: (Node node) {
            // Make sure to return a widget for each node
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, spreadRadius: 1)
                ],
              ),
              child: Text(node.key?.value ?? 'Undefined'),
            );
          },
        ),
      ),
    );
  }
}

class FamilyTreeViewPage extends StatelessWidget {
  final Tree tree;

  const FamilyTreeViewPage({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Family Tree'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: tree.buildView(context),
          ),
        ),
      ),
    );
  }
}
