class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final trimmedValue = value.trim(); // إزالة المسافات البيضاء
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(trimmedValue)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    final trimmedValue = value.trim(); // إزالة المسافات البيضاء
    if (trimmedValue.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')
        .hasMatch(trimmedValue)) {
      return 'Password must contain at least one letter and one number';
    }
    return null;
  }

  // Username validation
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    final trimmedValue = value.trim(); // إزالة المسافات البيضاء
    if (trimmedValue.length < 4) {
      return 'Username must be at least 4 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(trimmedValue)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }
}
