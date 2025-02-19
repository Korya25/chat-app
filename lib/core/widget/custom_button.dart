import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CustomButton is a reusable button widget that follows clean code principles.
/// It supports different styles (filled, outlined), loading state, disabled state,
/// custom text styles, and flexible dimensions.
///
/// ## Features:
/// - Supports filled and outlined button styles.
/// - Handles loading state with a progress indicator.
/// - Supports disabled state with reduced opacity.
/// - Customizable colors, text styles, padding, and border radius.
/// - Uses `InkWell` for better tap feedback.
///
/// ## Constructor Parameters:
/// | Parameter     | Type          | Description |
/// |--------------|--------------|-------------|
/// | `text`       | `String`      | The button text. |
/// | `onPressed`  | `VoidCallback?` | Callback when the button is pressed. |
/// | `isLoading`  | `bool`        | Whether to show a loading indicator. |
/// | `isDisabled` | `bool`        | Whether the button is disabled. |
/// | `color`      | `Color?`      | Background color of the button. |
/// | `textColor`  | `Color?`      | Color of the button text. |
/// | `borderRadius` | `double?`    | Radius for rounded corners. |
/// | `padding`    | `EdgeInsetsGeometry?` | Custom padding inside the button. |
/// | `width`      | `double?`     | Custom width of the button. |
/// | `height`     | `double?`     | Custom height of the button. |
/// | `buttonType` | `ButtonType`  | Determines if the button is filled or outlined. |

/// Enum to define button types: Filled or Outlined
enum ButtonType { filled, outlined }

class CustomButton extends StatelessWidget {
  final String text; // The button text
  final VoidCallback? onPressed; // Callback function when the button is pressed
  final bool isLoading; // If true, shows a loading spinner instead of text
  final bool isDisabled; // If true, disables the button
  final Color? color; // Background color for filled button type
  final Color? textColor; // Custom text color
  final double? borderRadius; // Radius for rounded corners
  final EdgeInsetsGeometry? padding; // Custom padding
  final double? width; // Custom width of the button
  final double? height; // Custom height of the button
  final ButtonType
      buttonType; // Determines whether the button is filled or outlined

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.buttonType = ButtonType.filled,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = !isLoading && !isDisabled;

    return SizedBox(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      child: InkWell(
        onTap: isButtonEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: Ink(
          decoration: BoxDecoration(
            color: buttonType == ButtonType.filled
                ? (isDisabled ? Colors.grey : color ?? AppColors.primaryColor)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            border: buttonType == ButtonType.outlined
                ? Border.all(color: color ?? AppColors.primaryColor, width: 2)
                : null,
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: textColor ?? Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor ??
                          (buttonType == ButtonType.filled
                              ? Colors.white
                              : color ?? AppColors.primaryColor),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// ## How to Use the CustomButton?
///
/// ### 1️⃣ Filled Button (Default Style)
/// ```dart
/// CustomButton(
///   text: "Submit",
///   onPressed: () => print("Button Pressed"),
/// )
/// ```
///
/// ### 2️⃣ Outlined Button
/// ```dart
/// CustomButton(
///   text: "Cancel",
///   onPressed: () => print("Cancel Pressed"),
///   buttonType: ButtonType.outlined,
///   color: Colors.red,
/// )
/// ```
///
/// ### 3️⃣ Disabled Button
/// ```dart
/// CustomButton(
///   text: "Disabled",
///   isDisabled: true,
/// )
/// ```
///
/// ### 4️⃣ Loading Button
/// ```dart
/// CustomButton(
///   text: "Loading...",
///   isLoading: true,
/// )
/// ```
///
/// ### 5️⃣ Custom Button with Different Styles
/// ```dart
/// CustomButton(
///   text: "Custom",
///   onPressed: () => print("Custom Pressed"),
///   color: Colors.green,
///   textColor: Colors.black,
///   borderRadius: 12.0,
/// )
/// ```
///
/// ## Enhancements & Future Improvements:
/// ✅ **Add Icon Support**: Allow adding an optional icon beside the text.
/// ✅ **Ripple Effect Customization**: Provide an option to change the ripple effect color.
/// ✅ **Dark Mode Support**: Adjust colors dynamically based on theme settings.
///
/// ## Conclusion
/// This `CustomButton` is a flexible, clean, and reusable button widget that follows best coding practices.
/// It supports multiple button types, states, and styles, making it a great addition to any Flutter project. 🚀
