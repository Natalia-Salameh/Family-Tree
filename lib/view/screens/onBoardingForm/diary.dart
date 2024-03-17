import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/view/screens/home/home.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/full_name.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Diary extends StatefulWidget {
  final double progress;
  const Diary({Key? key, required this.progress}) : super(key: key);

  @override
  State<Diary> createState() => _UserFormState();
}

class _UserFormState extends State<Diary> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final TextEditingController diaryController = TextEditingController();

  double progress = 1;

  @override
  Widget build(BuildContext context) {
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
                    progress: progress,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Leave a legacy for your descendants!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                    hintText: "Diary",
                    maxLines: 18,
                    myController: diaryController,
                    alignLabelWithHint: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        onPressed: () {
                          Get.to(Home());
                        },
                        color: CustomColors.primaryColor,
                        child: const Text(
                          "Get started",
                          style: TextStyle(color: CustomColors.white),
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
