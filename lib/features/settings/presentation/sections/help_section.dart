import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chat_app/core/constant/app_colors.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Help & Support', context),
        _buildListTile(
          text: 'Contact Us',
          icon: FontAwesomeIcons.headset,
          onTap: () => _navigateToContactUs(context),
          context: context,
        ),
        _buildListTile(
          text: 'Rate App on the Play Store',
          icon: FontAwesomeIcons.star,
          onTap: () => _navigateToRateApp(context),
          context: context,
        ),
        _buildListTile(
          text: 'About Us',
          icon: FontAwesomeIcons.circleInfo,
          onTap: () => _navigateToAbout(context),
          context: context,
        ),
        _buildListTile(
          text: 'Terms and Conditions',
          icon: FontAwesomeIcons.fileContract,
          onTap: () => _navigateToTermsAndConditions(context),
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

  void _navigateToContactUs(BuildContext context) {}

  void _navigateToRateApp(BuildContext context) {}

  void _navigateToAbout(BuildContext context) {}

  void _navigateToTermsAndConditions(BuildContext context) {}
}
