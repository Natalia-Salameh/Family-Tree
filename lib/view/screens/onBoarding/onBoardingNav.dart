import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/get_started.dart';
import 'on_boarding1.dart';
import 'on_boarding2.dart';
import 'on_boarding3.dart';

class OnBoardingWrapper extends StatefulWidget {
  const OnBoardingWrapper({Key? key}) : super(key: key);

  @override
  State<OnBoardingWrapper> createState() => _OnBoardingWrapperState();
}

class _OnBoardingWrapperState extends State<OnBoardingWrapper> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          Padding(
            padding: EdgeInsets.all(50),
            child: OnBoarding1(),
          ),
          OnBoarding2(),
          OnBoarding3(),
        ],
      ),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the indicator
        children: [
          SmoothPageIndicator(
            controller: _controller, // PageController
            count: 3,
            effect: WormEffect(
              dotWidth: 80, // Make dots wider
              dotHeight: 10, // Height of dots
              spacing: 8, // Space between dots
              activeDotColor: CustomColors.myCustomColor, // Active dot color
            ),
          ),
        ],
      ),
    );
  }
}
