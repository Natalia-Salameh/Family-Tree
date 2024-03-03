// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const MyTextFiled({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  }) : super(key: key);

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  bool _obscureText = true;
  bool _isValid = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
        child: Container(
            width: 353,
            height: 56,
            padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.01, vertical: screenHeight * 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                controller: widget.controller,
                obscureText: widget.obscureText ? _obscureText : false,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : _isValid
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                ),
                validator: (value) {
                  final isValid = widget.validator != null
                      ? widget.validator!(value) == null
                      : true;
                  setState(() {
                    _isValid = isValid;
                  });
                  return widget.validator != null
                      ? widget.validator!(value)
                      : null;
                },
              ))
            ])));
  }
}
