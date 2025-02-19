import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublicProfileData extends StatefulWidget {
  const PublicProfileData({
    super.key,
  });

  @override
  State<PublicProfileData> createState() => _PublicProfileDataState();
}

class _PublicProfileDataState extends State<PublicProfileData> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _statusFocusNode = FocusNode();

  String? initialUsername;
  String? initialStatus;

  @override
  void initState() {
    super.initState();
    initialUsername =
        "CurrentUsername"; // استبدل بالقيمة الحقيقية من قاعدة البيانات
    initialStatus =
        "CurrentStatus"; // استبدل بالقيمة الحقيقية من قاعدة البيانات
    _usernameController.text = initialUsername!;
    _statusController.text = initialStatus!;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _statusController.dispose();
    _usernameFocusNode.dispose();
    _statusFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Public Profile Data',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white70,
          ),
        ),

        // Status
        CustomTextFormField(
          hintText: 'Status',
          fillColor: Colors.white70,
          controller: _statusController,
          validator: (value) => value!.isEmpty ? 'Enter your status' : null,
          focusNode: _statusFocusNode,
          prefixIcon: Icon(
            FontAwesomeIcons.circleInfo,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
