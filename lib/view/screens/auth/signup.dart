// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:family_tree_application/constants/colors.dart';
import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/sign_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/imageasset.dart';

import '../../widgets/my_frame.dart';
import '../../widgets/my_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void SignUserUp() {}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context), // Go back
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.13),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                MyTextFiled(
                  controller: usernameController,
                  hintText: 'Email address',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFiled(
                  controller: usernameController,
                  hintText: 'Confirm password',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                SignButton(
                  onTap: SignUserUp,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        child: Divider(
                          thickness: 0.6,
                          color: CustomColors.dividercolor,
                        ),
                      ),
                    ),
                    Text(
                      ' Or Sign Up With ',
                      style: TextStyle(color: Color.fromARGB(255, 75, 73, 73)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        child: Divider(
                          thickness: 0.8,
                          color: CustomColors.dividercolor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                LogoButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
