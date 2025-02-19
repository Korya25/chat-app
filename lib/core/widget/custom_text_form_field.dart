import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// **📌 CustomTextFormField Widget**
///
/// This is a reusable custom TextFormField widget designed for flexibility.
/// It provides customization options for labels, hints, icons, and text validation.
///
/// **🎯 Features:**
/// ✅ Fully customizable text field with various styling options.
/// ✅ Supports prefix and suffix icons for better UI.
/// ✅ Customizable border, background color, and text styling.
/// ✅ Ideal for use in forms and input fields across the application.
///
/// **📌 Example Usage:**
/// ```dart
/// CustomTextFormField(
///   labelText: "Email",
///   hintText: "Enter your email",
///   keyboardType: TextInputType.emailAddress,
///   controller: emailController,
///   validator: (value) => value!.isEmpty ? "Required" : null,
/// )
/// ```
class CustomTextFormField extends StatelessWidget {
  /// **📝 Text Field Properties**
  final String? labelText; // Label displayed above the text field
  final String? hintText; // Hint text inside the field
  final TextStyle? hintStyle; // Style of the hint text
  final TextInputType
      keyboardType; // Determines keyboard type (e.g., email, number)
  final bool obscureText; // Used for password fields
  final TextEditingController? controller; // Controller to manage text input
  final String? Function(String?)? validator; // Validation function
  final Widget? prefixIcon; // Icon at the beginning of the text field
  final Widget?
      suffixIcon; // Icon at the end (e.g., eye for password visibility)
  final void Function(String)? onChanged; // Callback when text changes
  final int? maxLines; // Number of lines allowed (default: 1)
  final bool enabled; // Determines if the field is enabled or disabled
  final bool readOnly; // If true, the field is non-editable
  final bool autofocus; // If true, the field is focused on load
  final Color? fillColor; // Background color of the text field
  final Color focusedBorderColor; // Border color when focused
  final double? borderRadius; // Border radius for rounded corners
  final FocusNode? focusNode; // FocusNode to control focus manually
  final void Function(String)?
      onFieldSubmitted; // Callback when the user presses "Enter"
  final InputBorder? inputBorder; // Custom border for the text field
  final TextInputAction?
      textInputAction; // Defines action button (next, done, etc.)

  /// **📌 Constructor with Default Values**
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.fillColor,
    this.focusedBorderColor = AppColors.primaryColor,
    this.borderRadius,
    this.focusNode,
    this.onFieldSubmitted,
    this.hintStyle,
    this.inputBorder,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Assigning the text controller
      focusNode: focusNode, // Assigning the focus node
      onFieldSubmitted: onFieldSubmitted, // Handling submit event (Enter key)
      keyboardType: keyboardType, // Setting the keyboard type
      obscureText: obscureText, // Hiding text for password fields
      validator: validator, // Handling validation logic
      onChanged: onChanged, // Triggered when text changes
      maxLines: maxLines, // Setting max number of lines
      enabled: enabled, // Enabling or disabling input
      readOnly: readOnly, // Making field read-only if required
      autofocus:
          autofocus, // Automatically focusing the field when screen opens
      textInputAction:
          textInputAction, // Setting the keyboard action button (next, done, etc.)

      /// **🎨 Input Decoration for Styling**
      decoration: InputDecoration(
        labelText: labelText, // Displaying the label text
        hintText: hintText, // Displaying the hint text
        prefixIcon: prefixIcon, // Setting the prefix icon
        suffixIcon: suffixIcon, // Setting the suffix icon
        filled: true, // Enabling background color
        fillColor: fillColor ??
            AppColors.primaryColor
                .withAlpha((0.1 * 255).toInt()), // Background color

        /// **📌 Padding for Better UI**
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w, // Horizontal padding
          vertical: 8.h, // Vertical padding
        ),

        /// **🔳 Input Borders**
        border: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius ?? 24.r), // Default border radius
              borderSide: BorderSide.none, // No border by default
            ),
        enabledBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
              borderSide: BorderSide.none,
            ),
        focusedBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
              borderSide:
                  BorderSide(color: focusedBorderColor), // Focused border color
            ),

        /// **🎨 Custom Hint Style**
        hintStyle: hintStyle ??
            TextStyle(
              color: Colors.grey[600], // Default grey color
              fontSize: 14.sp, // Adaptive font size
            ),
      ),
    );
  }
}
