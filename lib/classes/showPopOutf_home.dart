import 'package:flutter/material.dart';

class PopupContent extends StatefulWidget {
  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    Column(
      children: [
        Text(
          "Welcome to Ajial!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
            "You can press the arrow next to a user to view their legacy and family tree."),
        SizedBox(height: 20),
        Image.asset(
          'assets/images/point2.png',
        ),
      ],
    ),
    Column(
      children: [
        Text(
          "Search Icon",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
            "You can click on the search icon to search for any member you are curious about their family tree!"),
        SizedBox(height: 20),
        Image.asset(
          'assets/images/handS.png',
        ),
      ],
    ),
    Column(
children: [
  Text("Create a Tree From Scratch!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Text("You Know a family tree that is not on the application yet? Then click the Add button in the bottom bar to create one!"),
         SizedBox(height: 20),
        Image.asset(
          'assets/images/AddClick.png',
        ),
  


],
    ),
     Column(
      children: [
        Text(
          "Fill the form to add the first Person!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
            "After you'ev added the first person select the role for the other person you want to add and so on.., Easy right !"),
        SizedBox(height: 20),
        Image.asset(
          'assets/images/FillForm.png',
        ),
      ],
    ),
    // Add more pages as needed
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: _pages[_currentPage],
      ),
      actions: <Widget>[
        if (_currentPage > 0)
          TextButton(
            child: Text("Previous"),
            onPressed: _previousPage,
          ),
        if (_currentPage < _pages.length - 1)
          TextButton(
            child: Text("Next"),
            onPressed: _nextPage,
          ),
        TextButton(
          child: Text("Got it"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
