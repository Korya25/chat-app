import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CustomTextButton is a reusable button widget designed for flexibility.
/// It provides customization options for text styling, padding, background color,
/// and splash effects while maintaining a clean and modern design.
///
/// ## Features:
/// - Fully customizable text button with various styling options.
/// - Uses `InkWell` for better touch feedback.
/// - Supports background color, splash effect, and text styling.
/// - Ideal for actions like navigation, submitting forms, or triggering events.
///
class CustomTextButton extends StatelessWidget {
  final String text; // Button text
  final VoidCallback onPressed; // Callback when the button is pressed
  final TextStyle? textStyle; // Custom text style
  final EdgeInsetsGeometry? padding; // Padding inside the button
  final Color? splashColor; // Splash effect color
  final Color? highlightColor; // Highlight color when button is pressed
  final Color? backgroundColor; // Background color of the button
  final Color? textColor; // Custom text color

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding,
    this.splashColor,
    this.highlightColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      // ignore: deprecated_member_use
      splashColor: splashColor ?? Colors.grey.withOpacity(0.2),
      highlightColor: highlightColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(8.0.r),
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black,
              ),
        ),
      ),
    );
  }
}

/// ## Usage:
///
/// ### 1️⃣ Basic Usage:
/// ```dart
/// CustomTextButton(
///   text: "Click Me",
///   onPressed: () => print("Button Pressed"),
/// )
/// ```
///
/// ### 2️⃣ Custom Styled Button:
/// ```dart
/// CustomTextButton(
///   text: "Submit",
///   onPressed: () {},
///   textStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
///   backgroundColor: Colors.blue,
///   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
/// )
/// ```
///
/// ## Future Enhancements:
/// ✅ **Disable state support**
/// ✅ **Loading indicator support**
/// ✅ **Additional button animations**
///
