// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:family_tree_application/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/my_button.dart';

import 'package:family_tree_application/view/widgets/my_textfield.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/functions/validinput.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Center(
              child: Form(
                key: con.formKey,
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
                          onPressed: () => Get.back(),
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
                      controller: con.usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      validator: (value) => validInput(value!, 'Username'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyTextFiled(
                      controller: con.passwordController,
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
                      key: UniqueKey(), // Updated
                      onTap: () {
                        con.logUserIn();
                      },
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
      ),
    );
  }
}
