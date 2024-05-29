import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Welcome",
        description: "This is a tutorial on how to use our app.",
        pathImage: "assets/images/bridge.png",
        backgroundColor: Colors.blueAccent,
      ),
    );
    slides.add(
      Slide(
        title: "Feature 1",
        description: "Description of Feature 1.",
        pathImage: "assets/images/story.png",
        backgroundColor: Colors.greenAccent,
      ),
    );
    slides.add(
      Slide(
        title: "Feature 2",
        description: "Description of Feature 2.",
        pathImage: "assets/images/ajial.png",
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  void onDonePress() {
    // Navigate to the main screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
      onSkipPress: onDonePress,
      showSkipBtn: true,
      showPrevBtn: true,
      showDoneBtn: true,
      showDotIndicator: true,
      colorDot: Colors.white,
      colorActiveDot: Colors.red,
      sizeDot: 13.0,
    );
  }
}
//"assets/images/bridge.png",