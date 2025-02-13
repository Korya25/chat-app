// lib/core/constants/styles.dart
import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle font22primaryW800(BuildContext context) {
    return TextStyle(
      color: AppColors.primaryColor,
      fontSize: 22.sp,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle font16blackW400(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font14primaryW500(BuildContext context) {
    return TextStyle(
      color: AppColors.primaryColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle font16primaryW900(BuildContext context) {
    return TextStyle(
      color: AppColors.primaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle font26blackW800(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: 26.sp,
      fontWeight: FontWeight.w800,
    );
  }
}
