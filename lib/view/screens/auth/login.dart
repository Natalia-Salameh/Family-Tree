import 'package:flutter/material.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/my_button.dart';
import 'package:family_tree_application/view/widgets/my_frame.dart';
import 'package:family_tree_application/view/widgets/my_textfield.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/functions/validinput.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void logUserIn() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoute.form,
      (route) => false,
    );
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
              autovalidateMode: AutovalidateMode.always,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.13),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 85,
                  ),
                  MyTextFiled(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    validator: (value) => validInput(value!, 'Username'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextFiled(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) => validInput(value!, 'Password'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: CustomColors.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                    onTap: logUserIn,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03),
                          child: Divider(
                            thickness: 0.6,
                            color: Color.fromARGB(255, 179, 174, 174),
                          ),
                        ),
                      ),
                      Text(
                        ' Or Login With ',
                        style: TextStyle(color: CustomColors.background),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03),
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
