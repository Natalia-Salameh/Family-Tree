import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/signup_controller.dart';
import '../../../core/constants/colors.dart';
import '../../../core/functions/validinput.dart';
import '../../widgets/logo_buttons.dart';
import '../../widgets/my_textfield.dart';
import '../../widgets/sign_button.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final SignUpController registerController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Form(
              key: registerController.formKey,
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
                          onPressed: () => Get.back(), // Go back
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
                      controller: registerController.usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      validator: (value) => validInput(value!, 'Username'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFiled(
                      controller: registerController.passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) => validInput(value!, 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFiled(
                      controller: registerController.confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      // validator: (value) {
                      //   if (value !=
                      //       registerController.passwordController.text) {
                      //     return 'Passwords do not match';
                      //   }
                      //   return validInput(value!, 'Password');
                      // },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SignButton(
                      key: UniqueKey(),
                      onTap: () async {
                        // if (registerController.formKey.currentState!
                        //     .validate()) {
                          await registerController.signUp();
                        // }
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
      ),
    );
  }
}
