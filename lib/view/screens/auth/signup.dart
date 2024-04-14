import 'package:family_tree_application/controller/signup_controller.dart';
import 'package:family_tree_application/core/constants/colors.dart';
import 'package:family_tree_application/core/functions/validinput.dart';
import 'package:family_tree_application/view/widgets/logo_buttons.dart';
import 'package:family_tree_application/view/widgets/my_textfield.dart';
import 'package:family_tree_application/view/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenHeight * 0.13),
                            child: Text(
                              "9".tr,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    MyTextField(
                      controller: registerController.usernameController,
                      hintText: "24".tr,
                      obscureText: false,
                      validator: (value) => validInput(value!, "24".tr),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: registerController.emailController,
                      hintText: "10".tr,
                      obscureText: false,
                      validator: (value) => validInput(value!, "10".tr),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: registerController.passwordController,
                      hintText: "12".tr,
                      obscureText: true,
                      validator: (value) => validInput(value!, "12".tr),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: registerController.confirmPasswordController,
                      hintText: "25".tr,
                      obscureText: true,
                      validator: (value) {
                        if (value !=
                            registerController.passwordController.text) {
                          return "26".tr;
                        }
                        return validInput(value!, "12".tr);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SignButton(
                      key: UniqueKey(),
                      onTap: () async {
                        if (registerController.formKey.currentState!
                            .validate()) {
                          await registerController.signUp();
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
                                horizontal: screenHeight * 0.02),
                            child: const Divider(
                              thickness: 0.6,
                              color: CustomColors.background,
                            ),
                          ),
                        ),
                        Text(
                          "27".tr,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 75, 73, 73)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenHeight * 0.02),
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
