class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Password must be at least 8 characters long";
    if (!RegExp(r'[A-Z]').hasMatch(value)) return "Must contain at least 1 uppercase letter";
    if (!RegExp(r'[a-z]').hasMatch(value)) return "Must contain at least 1 lowercase letter";
    if (!RegExp(r'[0-9]').hasMatch(value)) return "Must contain at least 1 number";
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) return "Must contain at least 1 special character";
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return "Confirm Password is required";
    if (value != password) return "Passwords do not match";
    return null;
  }
}
