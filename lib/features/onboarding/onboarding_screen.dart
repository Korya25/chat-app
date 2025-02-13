import 'package:chat_app/core/constant/app_assets.dart';
import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/constant/app_text_styles.dart';
import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // svg image
              SizedBox(height: 50),
              SizedBox(
                height: 300,
                width: 300,
                child: SvgPicture.asset(
                  AppAssets.onboarding,
                ),
              ),

              // title
              SizedBox(height: 220),
              Text(
                'As fast as lightning,\nas delicious as thunder!',
                textAlign: TextAlign.center,
                style: AppTextStyles.font22primaryW800(context),
              ),

              // Login Fotter Button
              SizedBox(height: 50),
              CustomButton(
                text: 'Login with your account',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginScreen);
                },
              ),

              // Sign up Fotter TextButton Button
              SizedBox(height: 20),

              Row(
                spacing: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(
                    text: 'New here?',
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  CustomTextButton(
                    text: 'Sign up',
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerScreen);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
