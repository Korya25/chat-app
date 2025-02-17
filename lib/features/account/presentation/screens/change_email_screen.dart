import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Email'),
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
                  hintText: 'Enter new email',
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
