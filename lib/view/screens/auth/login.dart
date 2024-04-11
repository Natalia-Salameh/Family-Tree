
import 'package:family_tree_application/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/my_button.dart';

import 'package:family_tree_application/view/widgets/my_textfield.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.put(LoginController());

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
                key: loginController.formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.13),
                          child: const Text(
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
                    MyTextField(
                      controller: loginController.usernameController,
                      hintText: 'Email',
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: loginController.passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                      child: const Row(
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
                      key: UniqueKey(),
                      onTap: () async {
                        if (loginController.formKey.currentState!.validate()) {
                          await loginController.login();
                        }
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
                            child: const Divider(
                              thickness: 0.6,
                              color: Color.fromARGB(255, 179, 174, 174),
                            ),
                          ),
                        ),
                        const Text(
                          ' Or Login With ',
                          style: TextStyle(color: CustomColors.background),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenHeight * 0.03),
                            child: const Divider(
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
                    const LogoButton()
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
