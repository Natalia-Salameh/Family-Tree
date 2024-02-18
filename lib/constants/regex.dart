import 'package:flutter/material.dart';

class RegexValidator {
  static String? validateUsername(String username) {
    if (!RegExp(r"^[a-zA-Z0-9._]+@gmail.com$").hasMatch(username)) {
      return 'Username must be a Gmail address.';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      return 'Password must contain at least one capital letter.';
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      return 'Password must contain at least one number.';
    }
    return null;
  }
}
