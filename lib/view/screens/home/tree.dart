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

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (100)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    _initializeGraph();
  }

  void _initializeGraph() {
    // Parent node for Marleen and Antoun
    final Node parent = Node.Id(1);
    graph.addNode(parent);

    // Nodes for their children
    final Node maram = Node.Id(2);
    final Node seleena = Node.Id(3);
    final Node marwa = Node.Id(4); // Marwa, also a parent
    graph.addNode(maram);
    graph.addNode(seleena);
    graph.addNode(marwa);

    // Connecting Marleen and Antoun's children
    graph.addEdge(parent, maram);
    graph.addEdge(parent, seleena);
    graph.addEdge(parent, marwa);

    // Maram's family
    final Node naya = Node.Id(6); // Maram and Jimmy's child
    graph.addNode(naya);
    graph.addEdge(maram, naya);

    // Marwa's family
    final Node eyyan = Node.Id(7);
    final Node tatiana = Node.Id(8);
    final Node abanoub = Node.Id(9);
    final Node ella = Node.Id(10);
    graph.addNode(eyyan);
    graph.addNode(tatiana);
    graph.addNode(abanoub);
    graph.addNode(ella);

    // Connecting Marwa's children
    graph.addEdge(marwa, eyyan);
    graph.addEdge(marwa, tatiana);
    graph.addEdge(marwa, abanoub);
    graph.addEdge(marwa, ella);
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
    if (node.key?.value == 1) {
      return _createParentNode(["Marleen", "Antoun"]);
    } else if (node.key?.value == 2) {
      return _createParentNode(["Maram", "Jimmy"]);
    } else if (node.key?.value == 4) {
      // Marwa and Issa, now a combined parent node
      return _createParentNode(["Marwa", "Issa"]);
    } else if ([6, 7, 8, 9, 10].contains(node.key?.value)) {
      // This includes Naya (Maram's child) and Marwa's children
      String name = "Child";
      switch (node.key!.value) {
        case 6:
          name = "Naya";
          break;
        case 7:
          name = "Eyyan";
          break;
        case 8:
          name = "Tatiana";
          break;
        case 9:
          name = "Abanoub";
          break;
        case 10:
          name = "Ella";
          break;
      }
      return _createChildNode(name);
    } else {
      // For other children (Seleena, Marwa before her update)
      String name = "Child";
      switch (node.key!.value) {
        case 3:
          name = "Seleena";
          break;
        default:
          name = "Unknown";
      }
      return _createChildNode(name);
    }
  }

  Widget _createParentNode(List<String> names) {
    List<Widget> nameWidgets = [];
    for (var name in names) {
      nameWidgets.add(_parentText(name));
      if (name != names.last) nameWidgets.add(VerticalDivider());
    }

    // Adjusting the padding and the decoration to try and make the node as circular as possible
    return Container(
      padding: EdgeInsets.all(10), // May need to adjust based on the content
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius:
            BorderRadius.circular(100), // High value to make it rounded
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: nameWidgets),
    );
  }

  Widget _createChildNode(String name) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16, vertical: 25), // Adjust for circular shape
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        shape: BoxShape.circle, // Making the shape circular
      ),
      child: Text(name, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _parentText(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
