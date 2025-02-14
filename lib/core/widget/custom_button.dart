import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      width: width ?? double.infinity.w,
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
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
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
