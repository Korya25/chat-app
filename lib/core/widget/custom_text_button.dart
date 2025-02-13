import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? backgroundColor;
  final Color? textColor;

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black,
              ),
        ),
      ),
    );
  }
}
