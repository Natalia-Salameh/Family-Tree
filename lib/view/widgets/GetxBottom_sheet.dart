import 'package:family_tree_application/view/screens/Forms/relative_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatefulWidget {
  final List<Image> images;
  final List<String> imageTexts = ['Parent', 'Spouse', 'Child'];

  CustomBottomSheet({required this.images});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
                onTap: () {
                  Get.to(
                    const UserAdd(),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: widget.images[currentIndex],
                    ),
                    Text(widget.imageTexts[currentIndex]),
                  ],
                )),
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
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (currentIndex > 0) {
                      setState(() {
                        currentIndex--;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (currentIndex < widget.images.length - 1) {
                      setState(() {
                        currentIndex++;
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
