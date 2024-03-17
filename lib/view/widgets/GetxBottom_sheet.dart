import 'package:family_tree_application/view/screens/onBoardingForm/add_familymember.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatefulWidget {
  final List<Image> images; // List of images

  CustomBottomSheet({required this.images});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int currentIndex = 0; // Current index of the selected image

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Navigate to the target page
                Get.to(
                  UserAdd(), // Replace DetailsPage with your target page
                );
              },
              child: widget.images[currentIndex], // Display the current image
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (currentIndex > 0) {
                      setState(() {
                        currentIndex--; // Decrease the currentIndex and update the state
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (currentIndex < widget.images.length - 1) {
                      setState(() {
                        currentIndex++; // Increase the currentIndex and update the state
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
