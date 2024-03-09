import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  double _scale = 1.0;
  get name => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _scale *= 1.5;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _scale /= 1.5;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                  scaleEnabled: false,
                  transformationController: TransformationController()
                    ..value = Matrix4.diagonal3Values(_scale, _scale, 1),
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // Create a new Node object for each node ID
                      final nodeKey = node.key!.value as int?;
                      final nodeObject = Node.Id(nodeKey!);

                      return rectangleWidget(nodeObject);
                    },
                  )),
            ),
          ],
        ));
  }

  //Random r = Random();

  Widget rectangleWidget(Node node) {
    return InkWell(
      onTap: () {
        // Create a new node with a unique ID
        final newNode = Node.Id(graph.nodeCount() + 1);

        // Add the new node as a child to the clicked node
        graph.addEdge(node, newNode);

        // Update the graph
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Node ${node.key!.value}'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Create a new node with a unique ID
                final newNode = Node.Id(graph.nodeCount() + 1);

                // Add the new node as a child to the clicked node
                graph.addEdge(node, newNode);

                // Update the graph
                setState(() {});
              },
              child: Text('Add child'),
            ),
          ],
        ),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id(1);

    graph.addNode(node1);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (100)
      ..subtreeSeparation = (10)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
