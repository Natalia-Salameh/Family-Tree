// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/sign_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/routes.dart';
import '../../../core/functions/validinput.dart';
import '../../widgets/my_frame.dart';
import '../../widgets/my_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void SignUserUp() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(AppRoute.verifyCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Center(
            child: Form(
              key: _formKey,
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
                    height: 80,
                  ),
                  MyTextFiled(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    validator: (value) => validInput(value!, 'Username'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFiled(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) => validInput(value!, 'Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFiled(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return validInput(value!, 'Password');
                    },
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
                            color: CustomColors.background,
                          ),
                        ),
                      ),
                      Text(
                        ' Or Sign Up With ',
                        style:
                            TextStyle(color: Color.fromARGB(255, 75, 73, 73)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02),
                          child: Divider(
                            thickness: 0.8,
                            color: CustomColors.background,
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
      ),
    );
  }
}
