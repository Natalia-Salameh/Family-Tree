import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:flutter/material.dart';

class FinalFamilyTree extends StatefulWidget {
  final double progress;
  const FinalFamilyTree({Key? key, required this.progress}) : super(key: key);

  @override
  State<FinalFamilyTree> createState() => _UserFormState();
}

class _UserFormState extends State<FinalFamilyTree> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

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
                    "Here is your final family tree for now!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Button(
                        onPressed: () {},
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
