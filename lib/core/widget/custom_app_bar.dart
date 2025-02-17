import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool centerTitle;
  final IconThemeData? iconTheme;

  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor = AppColors.primaryColor,
    this.centerTitle = true,
    this.iconTheme,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(
            title ?? 'title',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      iconTheme: iconTheme ?? IconThemeData(color: Colors.white),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
