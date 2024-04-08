String? validInput(String val, String field) {
  if (val.isEmpty) {
    return "$field can't be empty";
  } else if (field == 'Email') {
    if (!val.contains('@')) {
      return 'A valid email address is required';
    }
  } else if (field == 'Username') {
    if (val.length < 6 || val.length > 100) {
      return 'The username must be between 6 and 100 characters long.';
    }
  } else if (field == 'Password') {
    if (val.length < 8) {
      return "$field must be at least 8 characters";
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(val)) {
      return "$field must contain at least one lowercase letter";
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) {
      return "$field must contain at least one uppercase letter";
    } else if (!RegExp(r'(?=.*\d)').hasMatch(val)) {
      return "$field must contain at least one digit";
    } else if (!RegExp(r'(?=.*[!@#$%^&*()_+=|<>?{}[\]~-])').hasMatch(val)) {
      return "$field must contain at least one special character";
    }
  }

  return null;
}
