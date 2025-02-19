import 'package:chat_app/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chat_app/core/constant/app_colors.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Account'),
        _buildListTile(
          text: 'Profile',
          icon: FontAwesomeIcons.user,
          onTap: () => _navigateToProfile(context),
        ),
        _buildListTile(
          text: 'Account',
          icon: FontAwesomeIcons.lock,
          onTap: () => _navigateToAccountSettings(context),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.profile);
  }

  void _navigateToAccountSettings(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.account);
  }
}
