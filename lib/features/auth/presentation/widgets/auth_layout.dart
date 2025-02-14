import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:chat_app/features/auth/presentation/widgets/intro_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String introTitle;
  final String introSubtitle;
  final List<Widget> formFields;
  final GlobalKey<FormState> formKey;
  final String submitButtonText;
  final VoidCallback onSubmit;
  final bool isLoading;
  final String errorMessage;
  final bool showForgotPassword;
  final void Function()? onForgotPassword;

  const AuthLayout({
    super.key,
    required this.title,
    required this.introTitle,
    required this.introSubtitle,
    required this.formFields,
    required this.formKey,
    required this.submitButtonText,
    required this.onSubmit,
    this.isLoading = false,
    this.errorMessage = '',
    this.showForgotPassword = false,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                IntroMessage(
                  title: introTitle,
                  subTitle: introSubtitle,
                ),
                SizedBox(height: 30.h),
                ...formFields,
                if (showForgotPassword)
                  Center(
                    child: CustomTextButton(
                      text: 'Forgot password?',
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: onForgotPassword ?? () {},
                    ),
                  ),
                if (errorMessage.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                SizedBox(height: 20.h),
                CustomButton(
                  onPressed: onSubmit,
                  text: submitButtonText,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
