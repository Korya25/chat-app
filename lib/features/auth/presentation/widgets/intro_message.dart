import 'package:chat_app/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroMessage extends StatelessWidget {
  final String title;
  final String subTitle;
  const IntroMessage({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.font26blackW800(context),
        ),
        SizedBox(height: 5.h),
        Text(
          subTitle,
          style: AppTextStyles.font16blackW400(context)
              .copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
