import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:chat_app/features/auth/widget/intro_message.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
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

  const AuthScreen({
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
            fontSize: 20,
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                IntroMessage(
                  title: introTitle,
                  subTitle: introSubtitle,
                ),
                const SizedBox(height: 30),
                ...formFields,
                if (showForgotPassword)
                  Center(
                    child: CustomTextButton(
                      text: 'Forgot password?',
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: onForgotPassword ?? () {},
                    ),
                  ),
                if (errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
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
