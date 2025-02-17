import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({super.key});

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Username'),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 30.h,
              children: [
                CustomTextFormField(
                  controller: usernameController,
                  prefixIcon: Icon(FontAwesomeIcons.user),
                  hintText: 'Enter new username',
                ),
                CustomButton(
                  text: 'Update',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
