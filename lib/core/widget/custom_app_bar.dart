import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CustomAppBar is a reusable app bar widget that provides flexibility
/// for different use cases, including standard app bars and a search mode.
///
/// Features:
/// - Supports normal `AppBar`.
/// - Allows customization of title, leading widget, and actions.
/// - Includes an optional search mode with a `TextField`.
/// - Customizable background color and icon theme.
/// - Supports external text styles for the title.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // Title text for the app bar
  final Widget? titleWidget; // Custom title widget if needed
  final Widget? leading; // Leading widget (e.g., back button)
  final List<Widget>? actions; // List of action widgets
  final Color? backgroundColor; // Background color of the app bar
  final bool centerTitle; // Whether the title is centered
  final IconThemeData? iconTheme; // Custom icon theme
  final bool isSearchMode; // Whether to show a search input
  final Function(String)? onSearchChanged; // Callback for search input changes
  final TextStyle? titleStyle; // Custom text style for the title

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.iconTheme,
    this.isSearchMode = false,
    this.onSearchChanged,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(),
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      centerTitle: centerTitle,
      iconTheme: iconTheme ?? const IconThemeData(color: Colors.white),
    );
  }

  /// Builds the title widget based on search mode.
  /// If `isSearchMode` is enabled, it shows a search field.
  /// Otherwise, it displays a text title or a custom widget.
  Widget _buildTitle() {
    if (isSearchMode) {
      return TextField(
        onChanged: onSearchChanged,
        decoration: const InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
      );
    }
    return titleWidget ??
        Text(
          title ?? 'Title',
          style: titleStyle ??
              TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// ## How to Use the CustomAppBar?
///
/// ### 1️⃣ Normal AppBar with Title
/// ```dart
/// CustomAppBar(
///   title: "Home",
/// )
/// ```
///
/// ### 2️⃣ AppBar with Custom Widget (Logo)
/// ```dart
/// CustomAppBar(
///   titleWidget: Image.asset('assets/logo.png'),
/// )
/// ```
///
/// ### 3️⃣ AppBar with a Search Field
/// ```dart
/// CustomAppBar(
///   isSearchMode: true,
///   onSearchChanged: (query) {
///     print("Search query: $query");
///   },
/// )
/// ```
///
/// ### 4️⃣ AppBar with Custom Actions
/// ```dart
/// CustomAppBar(
///   title: "Settings",
///   actions: [
///     IconButton(
///       icon: Icon(Icons.notifications),
///       onPressed: () => print("Notifications clicked"),
///     ),
///   ],
/// )
/// ```
