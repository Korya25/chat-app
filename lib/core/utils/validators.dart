class Validators {
  // ❌ Common error messages stored as constants
  static const String _requiredField = 'This field is required';
  static const String _invalidEmail = 'Please enter a valid email address';
  static const String _shortPassword = 'Password must be at least 6 characters';
  static const String _weakPassword =
      'Password must contain at least one letter and one number';
  static const String _shortUsername = 'Username must be at least 4 characters';
  static const String _invalidUsername =
      'Username can only contain letters, numbers, and underscores';

  // ✅ Define regular expressions once to avoid repeated compilation
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

  /// ✅ Private method to check if the input field is empty
  /// - Returns an error message if the value is null or only contains spaces.
  /// - Otherwise, it returns `null` (which means the value is valid).
  static String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _requiredField;
    }
    return null; // Input is valid
  }

  /// 📧 **Validate Email**
  /// - First, check if the field is empty using `_validateRequired()`
  /// - Then, use `_emailRegex` to verify the email format
  static String? validateEmail(String? value) {
    final error = _validateRequired(value);
    if (error != null) return error; // Field is empty

    final trimmedValue = value!.trim(); // Remove spaces before validation
    if (!_emailRegex.hasMatch(trimmedValue)) {
      return _invalidEmail; // Invalid email format
    }
    return null; // Email is valid
  }

  /// 🔐 **Validate Password**
  /// - Checks if the field is empty
  /// - Ensures it has at least 6 characters
  /// - Ensures it contains **at least one letter and one number**
  static String? validatePassword(String? value) {
    final error = _validateRequired(value);
    if (error != null) return error; // Field is empty

    final trimmedValue = value!.trim();
    if (trimmedValue.length < 6) return _shortPassword; // Too short
    if (!_passwordRegex.hasMatch(trimmedValue))
      return _weakPassword; // Weak password

    return null; // Password is valid
  }

  /// 👤 **Validate Username**
  /// - Checks if the field is empty
  /// - Ensures it has at least 4 characters
  /// - Allows only letters, numbers, and underscores
  static String? validateUsername(String? value) {
    final error = _validateRequired(value);
    if (error != null) return error; // Field is empty

    final trimmedValue = value!.trim();
    if (trimmedValue.length < 4) return _shortUsername; // Too short
    if (!_usernameRegex.hasMatch(trimmedValue)) {
      return _invalidUsername; // Invalid characters
    }

    return null; // Username is valid
  }
}
