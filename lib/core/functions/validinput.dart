String? validInput(String val, String field) {
  // Check if the value is empty
  if (val.isEmpty) {
    return "$field can't be empty";
  } else if (field == 'Username') {
    // Removed the check for "@gmail.com"
    // You can add other username validations here if needed
  } else if (field == 'Password') {
    // Password length check
    if (val.length < 8) {
      return "$field must be at least 8 characters";
    }
    // At least one lowercase letter check
    else if (!RegExp(r'(?=.*[a-z])').hasMatch(val)) {
      return "$field must contain at least one lowercase letter";
    }
    // At least one uppercase letter check
    else if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) {
      return "$field must contain at least one uppercase letter";
    }
    // At least one digit check
    else if (!RegExp(r'(?=.*\d)').hasMatch(val)) {
      return "$field must contain at least one digit";
    }
    // At least one special character check
    else if (!RegExp(r'(?=.*[!@#$%^&*()_+=|<>?{}[\]~-])').hasMatch(val)) {
      return "$field must contain at least one special character";
    }
  }
  // If all checks pass, return null
  return null;
}
