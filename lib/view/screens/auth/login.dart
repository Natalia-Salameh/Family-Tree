// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_frame.dart';
import '../../widgets/my_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void logUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
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
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 39, 39),
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
                      child: Divider(
                        thickness: 0.6,
                        color: const Color.fromARGB(255, 132, 128, 128),
                      ),
                    ),
                    Text(
                      ' Or Login With ',
                      style: TextStyle(color: Color.fromARGB(255, 75, 73, 73)),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.8,
                        color: Color.fromARGB(255, 168, 164, 164),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Frame(imagePath: 'lib/images/Google.png'),
                    const SizedBox(
                      width: 30,
                    ),
                    Frame(imagePath: 'lib/images/facebook.png'),
                    const SizedBox(
                      width: 30,
                    ),
                    Frame(imagePath: 'lib/images/Apple.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
