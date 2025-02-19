import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/features/account/presentation/widget/delate_acciunt_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: CustomAppBar(
          title: 'Account Settings',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                _buildListTile(
                  text: 'Change Username',
                  icon: FontAwesomeIcons.user,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.changeUsername),
                ),
                _buildListTile(
                    text: 'Change Email',
                    icon: FontAwesomeIcons.envelope,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.changeEmail)),
                _buildListTile(
                    text: 'Update Password',
                    icon: FontAwesomeIcons.lock,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.updatePassword)),
                SizedBox(height: 40),
                DeleteAccountButton(),
              ],
            ),
          ),
        ));
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
}
