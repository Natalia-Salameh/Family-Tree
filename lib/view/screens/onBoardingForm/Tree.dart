import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/diary.dart';
import 'package:family_tree_application/view/widgets/GetxBottom_sheet.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import this package to use icons

class TreeState extends StatefulWidget {
  final double progress;
  const TreeState({Key? key, required this.progress}) : super(key: key);

  @override
  State<TreeState> createState() => _UserFormState();
}

class _UserFormState extends State<TreeState> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late DateTime dateTime;
  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ProgressBar(
                  progress: widget.progress,
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
                        setState(() {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Diary(
                                progress: progress,
                              ),
                            ),
                            (route) => false,
                          );
                          progress = progress + 0.5;
                        });
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
