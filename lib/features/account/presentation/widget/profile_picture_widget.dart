// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showChangePictureOptions,
          child: CircleAvatar(
            radius: 50.r,
            backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
        ),
        SizedBox(height: 10.h),
        CustomTextButton(
          text: 'Change Picture',
          textStyle: TextStyle(fontSize: 16.sp, color: Colors.blue),
          onPressed: _showChangePictureOptions,
        ),
      ],
    );
  }

  void _showChangePictureOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
      builder: (_) => Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBottomSheetItem(
              icon: Icons.camera_alt_outlined,
              title: 'Take a photo',
              onTap: _takePhoto,
            ),
            _buildBottomSheetItem(
              icon: Icons.photo_library_outlined,
              title: 'Select from Gallery',
              onTap: _selectPhoto,
            ),
            _buildBottomSheetItem(
              icon: Icons.delete_outline,
              title: 'Delete Profile Picture',
              color: Colors.red,
              onTap: _deleteProfilePicture,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem({
    required IconData icon,
    required String title,
    Color color = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  Future<void> _selectPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  void _deleteProfilePicture() {
    setState(() => _profileImage = null);
  }
}
