import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/diary.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
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
                const SizedBox(height: 185),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      // This is the profile circle in the middle of the page
                      backgroundImage: AssetImage(AppImageAsset.father),
                      radius: 45,
                      backgroundColor: Color.fromARGB(255, 141, 153, 163),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          CustomBottomSheet(
                            images: [
                              Image.asset(
                                AppImageAsset.couple,
                                height: 50,
                              ),
                              Image.asset(
                                AppImageAsset.child,
                              ),
                              Image.asset(
                                AppImageAsset.mother,
                              ),
                              /* Add more images here */
                              Image.asset(
                                AppImageAsset.father,
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        );
                      },
                      // Rest of your code...

                      child: const CircleAvatar(
                        // This is the circular add icon on the right bottom side of the node
                        radius: 15,
                        backgroundColor: Color.fromARGB(255, 243, 239, 239),
                        child: Icon(Icons.add,
                            size: 20, color: Color.fromARGB(255, 9, 9, 9)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
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
