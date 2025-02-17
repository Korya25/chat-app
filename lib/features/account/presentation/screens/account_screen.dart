import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
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
        child: Column(
          spacing: 10,
          children: [
            _buildListTile(
              text: 'Change Username',
              icon: FontAwesomeIcons.user,
              onTap: () =>
                  Navigator.pushNamed(context, Routes.changeUsernameScreen),
            ),
            _buildListTile(
                text: 'Change Email',
                icon: FontAwesomeIcons.envelope,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.changeEmailScreen)),
            _buildListTile(
                text: 'Update Password',
                icon: FontAwesomeIcons.lock,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.updatePasswordScreen)),
            SizedBox(height: 40),
            CustomTextButton(
              text: 'Delete Account',
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.red,
              ),
              onPressed: () {
                _showDeleteAccountDialog();
              },
            ),
          ],
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

  // confirm delete account Dialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm account Deletion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be reversed. Type your username to confirm.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          actions: [
            Column(
              spacing: 20.h,
              children: [
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Enter your username',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                CustomButton(
                  color: Colors.grey,
                  height: 40,
                  onPressed: () {
                    // Perform delete account action
                    Navigator.pop(context);
                  },
                  text: 'Delete',
                ),
                CustomButton(
                  color: Colors.grey,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
