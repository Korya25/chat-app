import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/features/account/presentation/widget/private_data_section.dart';
import 'package:chat_app/features/account/presentation/widget/profile_picture_widget.dart';
import 'package:chat_app/features/account/presentation/widget/public_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            ProfilePictureWidget(),
            PublicProfileData(),
            PrivateDataSection(),
          ],
        ),
      ),
    );
  }
}
