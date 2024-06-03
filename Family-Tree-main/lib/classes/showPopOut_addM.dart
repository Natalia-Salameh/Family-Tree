import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:flutter/material.dart';

class PopupContentTree extends StatefulWidget {
  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContentTree> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    Column(
      children: [
        const Text(
          "How about we get Started by creating your tree first?",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
            "First thing you have to do is to fill your information in the form then click the Next button!"),
        const SizedBox(height: 20),
        Image.asset(AppImageAsset.filltreeform),
      ],
    ),
    Column(
      children: [
        const Text(
          "Here you can see your self as a node",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text("You can click on the add icon to open the bottom sheet"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(17),
          child: Image.asset(AppImageAsset.clicktoadd),
        ),
      ],
    ),

    Column(
      children: [
        const Text(
          "Add Family Member",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            "You can select the role of the family member you want to add by clicking on the icon, and you can navigate between role by pressing the arrow"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(17),
          child: Image.asset(AppImageAsset.bttomS),
        ),
      ],
    ),
    Column(
      children: [
        const Text(
          "Add child",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            "You will not be able to add a child unless you add a spouse first, so you have to add a spouse and fill the merriage date if still married"),
        const SizedBox(height: 20),
        Image.asset(AppImageAsset.mDate),
      ],
    ),

    Column(
      children: [
        const Text(
          "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            "After adding a spouse you can click the add button in the middle, and a child form will open"),
        const SizedBox(height: 20),
        Image.asset("assets/images/addChildP.png"),
      ],
    ),
    Column(
      children: [
        const Text(
          "Child Form",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            "Here is the child form, after you fill it a click add a child should be added and connected to the parents you can add more childs by repating the same step!"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(child: Image.asset("assets/images/childForm.png")),
        ),
      ],
    ),
    Column(
      children: [
        const Text(
          "Final Tree",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Here is how your final tree might look!"),
        const SizedBox(height: 20),
        Image.asset("assets/images/finaltree.png"),
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
            child: const Text("Previous"),
            onPressed: _previousPage,
          ),
        if (_currentPage < _pages.length - 1)
          TextButton(
            child: const Text("Next"),
            onPressed: _nextPage,
          ),
        TextButton(
          child: const Text("Got it"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
