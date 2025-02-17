import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chat_app/core/constant/app_colors.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Preferences', context),
        _buildListTile(
          text: 'Chat Bubbles',
          icon: FontAwesomeIcons.message,
          onTap: () => _navigateToChatsBubble(context),
          context: context,
        ),
        _buildListTile(
          text: 'Privacy & Social',
          icon: FontAwesomeIcons.shareNodes,
          onTap: () => _navigateToPrivacyAndSocial(context),
          context: context,
        ),
        _buildListTile(
          text: 'Language',
          icon: FontAwesomeIcons.language,
          onTap: () => _navigateToLanguageSettings(context),
          context: context,
        ),
        _buildListTile(
          text: 'Theme',
          icon: FontAwesomeIcons.moon,
          onTap: () => _navigateToThemeSettings(context),
          context: context,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      tileColor: AppColors.primaryColor,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
      leading: Icon(icon, color: Colors.white, size: 20),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18.sp,
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }

  void _navigateToChatsBubble(BuildContext context) {}

  void _navigateToPrivacyAndSocial(BuildContext context) {}

  void _navigateToLanguageSettings(BuildContext context) {}

  void _navigateToThemeSettings(BuildContext context) {}
}
