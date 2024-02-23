import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/view/screens/onBoeardingForm/final_family_tree.dart';
import 'package:family_tree_application/view/widgets/button.dart';
import 'package:family_tree_application/view/widgets/form/progress_Indicator.dart';
import 'package:family_tree_application/view/widgets/profile.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                ProgressBar(
                  progress: widget.progress,
                ),
                const Text(
                  "Click on the add button to start adding your relatives!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Profile(),
                SizedBox(
                  height: 40,
                  child: Button(
                      onPressed: () {
                        setState(() {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FinalFamilyTree(
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
