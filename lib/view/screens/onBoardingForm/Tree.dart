import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/diary.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TreeState extends StatelessWidget {
  const TreeState({super.key});

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<ProgressController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ProgressBar(
                  progress: progressController.progress.value,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Click on the add button to start adding your relatives!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 500),
                SizedBox(
                  height: 40,
                  child: Button(
                      onPressed: () {
                        progressController.updateProgress();
                        Get.offAllNamed(AppRoute.diary);
                      },
                      color: CustomColors.primaryColor,
                      child: const Text(
                        "Next",
                        style: TextStyle(color: CustomColors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
