import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';



class FamilyTreePage extends StatefulWidget {
  @override
  _FamilyTreePageState createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends State<FamilyTreePage> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    // Initialize the tree configuration
    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (100)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    _initializeGraph();
  }

  void _initializeGraph() {
    // Creating a unified node for Marleen and Antoun
    final Node parent = Node.Id(1);
    graph.addNode(parent);

    // Creating child nodes
    final Node child1 = Node.Id(2);
    final Node child2 = Node.Id(3);
    final Node child3 = Node.Id(4);

    // Adding child nodes to the graph
    graph.addNode(child1);
    graph.addNode(child2);
    graph.addNode(child3);

    // Connecting children to the parent
    graph.addEdge(parent, child1);
    graph.addEdge(parent, child2);
    graph.addEdge(parent, child3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Family Tree"),
      ),
      body: Column(
        children: [
          _zoomControls(),
          Expanded(
            child: InteractiveViewer(
              transformationController: TransformationController()
                ..value = Matrix4.diagonal3Values(_scale, _scale, 1),
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child: GraphView(
                graph: graph,
                algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                builder: (Node node) {
                  // Custom widget for nodes
                  return _nodeWidget(node);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.zoom_in),
          onPressed: () {
            setState(() {
              _scale *= 1.2;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: () {
            setState(() {
              _scale /= 1.2;
            });
          },
        ),
      ],
    );
  }

  Widget _nodeWidget(Node node) {
    // Determine if this is the parent node
    if (node.key?.value == 1) {
      // Parent Node
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _parentText("Marleen"),
            VerticalDivider(),
            _parentText("Antoun"),
          ],
        ),
      );
    } else {
      // Child Node
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('Child Node ${node.key!.value}',
            style: TextStyle(fontSize: 16)),
      );
    }
  }

  Widget _parentText(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
