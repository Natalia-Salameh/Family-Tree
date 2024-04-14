import 'package:family_tree_application/controller/diary_controller.dart';
import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Diary extends StatelessWidget {
  const Diary({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();
    final storyController = Get.put(DiaryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProgressBar(
                    progress: progressController.progress.value,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "53".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomTextForm(
                      hintText: "35".tr,
                      myController: storyController.educationController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomTextForm(
                      hintText: "36".tr,
                      myController: storyController.workController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextForm(
                    hintText: "41".tr,
                    maxLines: 14,
                    myController: storyController.diaryController,
                    alignLabelWithHint: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        onPressed: () async {
                          await storyController.getStarted();
                        },
                        color: CustomColors.primaryColor,
                        child: Text(
                          "5".tr,
                          style: const TextStyle(color: CustomColors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
