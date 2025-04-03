String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null; // No error
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Phone number is required.";
  } else if (!RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)) {
    return "Enter a valid phone number (10-15 digits, with optional '+' prefix).";
  }
  return null; // No error
}


String? validateEmptyField(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Enter valid";
  } else if (!RegExp(r"^[a-zA-Z]+(\s[a-zA-Z]+)+$").hasMatch(value)) {
    return "Enter a valid full name (e.g., John Doe).";
  }
  return null; // No error
}
String? validateFullName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Full name is required.";
  } else if (!RegExp(r"^[a-zA-Z]+(\s[a-zA-Z]+)+$").hasMatch(value)) {
    return "Enter a valid full name (e.g., John Doe).";
  }
  return null; // No error
}

String? validatePassword(String value) {
  //final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$');

  if (value.isEmpty) {
    return 'Please enter your password';
  }
  // else if (!passwordRegex.hasMatch(value)) {
  //   return 'Password must be alphanumeric';
  // }
  else if (value.length < 6) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}
