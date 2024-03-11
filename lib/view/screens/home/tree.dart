import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class FamilyMember {
  final String name;
  final Color color;
  final Offset position;

  FamilyMember(this.name, this.color, this.position);
}

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration()
    ..siblingSeparation = (100)
    ..levelSeparation = (120)
    ..subtreeSeparation = (80)
    ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  final Map<String, FamilyMember> familyMembers = {
    'Amir': FamilyMember('Amir', Colors.green, Offset(100, 100)),
    'Sandy': FamilyMember('Sandy', Colors.yellow, Offset(200, 100)),
    'Fida': FamilyMember('Fida', Colors.pink, Offset(300, 200)),
    'Nour': FamilyMember('Nour', Colors.blue, Offset(400, 200)),
    'Fadi': FamilyMember('Fadi', Colors.orange, Offset(150, 300)),
    'Dyala': FamilyMember('Dyala', Colors.purple, Offset(350, 300)),
    'Leen': FamilyMember('Leen', Colors.red, Offset(250, 400)),
    'Maram': FamilyMember('Maram', Colors.teal, Offset(300, 500)),
  };

  @override
  void initState() {
    super.initState();

    // Create nodes for each family member
    familyMembers.forEach((index, member) {
      graph.addNode(Node.Id(index));
    });

    // Connect the nodes to form the family tree
    graph.addEdge(Node.Id(1), Node.Id(5)); // Amir -> Fadi
    graph.addEdge(Node.Id(2), Node.Id(5)); // Sandy -> Fadi
    graph.addEdge(Node.Id(3), Node.Id(6)); // Fida -> Dyala
    graph.addEdge(Node.Id(4), Node.Id(6)); // Nour -> Dyala
    graph.addEdge(Node.Id(5), Node.Id(7)); // Fadi -> Leen
    graph.addEdge(Node.Id(6), Node.Id(7)); // Dyala -> Leen
    graph.addEdge(Node.Id(5), Node.Id(8)); // Fadi -> Maram
    graph.addEdge(Node.Id(6), Node.Id(8)); // Dyala -> Maram
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Tree'),
      ),
      body: Stack(
        children: [
          // Draw the lines
          CustomPaint(
            size: Size.infinite,
            painter: LinePainter(familyMembers),
          ),
          // Draw the nodes
          ...familyMembers.entries.map((entry) {
            return Positioned(
              left: entry.value.position.dx,
              top: entry.value.position.dy,
              child: familyMemberWidget(entry.value),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget familyMemberWidget(FamilyMember member) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: member.color,
        shape: BoxShape.circle,
      ),
      child: Text(
        member.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Map<String, FamilyMember> familyMembers;

  LinePainter(this.familyMembers);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Define the lines here
    // For example, to draw a line from Amir to Fadi:
    canvas.drawLine(
      familyMembers['Amir']!.position,
      familyMembers['Fadi']!.position,
      paint,
    );

    // Draw the rest of the lines
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
