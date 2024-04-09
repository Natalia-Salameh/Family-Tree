import 'package:family_tree_application/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class FamilyTreePage extends StatefulWidget {
  const FamilyTreePage({Key? key}) : super(key: key);

  @override
  _FamilyTreePageState createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends State<FamilyTreePage> {
  final Graph graph = Graph()..isTree = true;
  final buchheimWalkerConfig = BuchheimWalkerConfiguration()
    ..siblingSeparation = 100
    ..levelSeparation = 150
    ..subtreeSeparation = 150
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

  @override
  void initState() {
    super.initState();
    _buildGraphFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(buchheimWalkerConfig, TreeEdgeRenderer(buchheimWalkerConfig)),
          paint: Paint()
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) => _nodeWidget(node),
        ),
      ),
    );
  }

  Widget _nodeWidget(Node node) {
    final personData = MockData.person;
    final names = _findNodeNames(node.key!.value, personData);
    final isChild = names.length == 1 && node.key!.value != personData['id'];
    
    return _createNodeWidget(names, isChild: isChild);
  }

  List<String> _findNodeNames(int nodeId, Map<String, dynamic> personData) {
    List<String> names = [];

    void addChildNames(dynamic childData) {
      if (childData['id'] == nodeId) {
        names.add(childData['firstName']);
      }
    }

    if (nodeId == personData['id']) {
      names.add(personData['FirstName']);
      personData['Spouses']?.forEach((spouse) {
        names.add(spouse['Partner']['firstName']);
        spouse['Partner']['Children']?.forEach((child) => addChildNames(child['Child']));
      });
    } else {
      personData['Spouses']?.forEach((spouse) {
        if (spouse['Partner']['id'] == nodeId) {
          names.add(spouse['Partner']['firstName']);
        }
        spouse['Partner']['Children']?.forEach((child) => addChildNames(child['Child']));
      });
    }

    if (names.isEmpty) names.add("Unknown");
    return names;
  }

  Widget _createNodeWidget(List<String> names, {bool isChild = false}) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      children: names.map((name) => Padding(
            padding: EdgeInsets.all(isChild ? 8.0 : 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 30),
                Text(name),
              ],
            ),
          )).toList(),
    );
  }

  void _buildGraphFromJson() {
    final personData = MockData.person;
    final Node rootNode = Node.Id(personData['id']);
    graph.addNode(rootNode);

    personData['Spouses']?.forEach((spouse) {
      final partnerData = spouse['Partner'];
      final Node spouseNode = Node.Id(partnerData['id']);
      graph.addNode(spouseNode);
      graph.addEdge(rootNode, spouseNode);

      partnerData['Children']?.forEach((child) {
        final Node childNode = Node.Id(child['Child']['id']);
        graph.addNode(childNode);
        graph.addEdge(spouseNode, childNode);
      });
    });
  }
}
