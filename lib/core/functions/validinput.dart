String? validInput(String val, String field) {
  if (val.isEmpty) {
    return "$field can't be empty";
  } else if (field == 'Username') {
    if (!val.endsWith('@gmail.com')) {
      return "$field must end with @gmail.com";
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
