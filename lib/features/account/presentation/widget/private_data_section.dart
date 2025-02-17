// ignore_for_file: deprecated_member_use

import 'package:chat_app/core/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivateDataSection extends StatefulWidget {
  const PrivateDataSection({super.key});

  @override
  State<PrivateDataSection> createState() => _PrivateDataSectionState();
}

class _PrivateDataSectionState extends State<PrivateDataSection> {
  String? _selectedGender;
  DateTime? _selectedBirthday;
  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 5.w,
          children: [
            Text(
              'Private Data',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white70,
              ),
            ),
            Icon(
              FontAwesomeIcons.circleQuestion,
              size: 16.sp,
              color: Colors.white70,
            ),
          ],
        ),
        _CustomSelectionField(
          label: 'Sex',
          value: _selectedGender ?? 'Select Gender',
          icon: _selectedIcon ?? FontAwesomeIcons.venusMars,
          onTap: () => _showGenderBottomSheet(),
        ),

        // Birthday Selection
        _CustomSelectionField(
          label: 'Birthday',
          value: _selectedBirthday != null
              ? '${_selectedBirthday!.day}/${_selectedBirthday!.month}/${_selectedBirthday!.year}'
              : 'Select Date',
          icon: FontAwesomeIcons.cakeCandles,
          onTap: () => _showCupertinoDatePicker(),
        ),
      ],
    );
  }

  // Show bottom sheet for gender selection
  void _showGenderBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sex',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              _buildBottomSheetItem(Icons.male, 'Male', Colors.blue, () {
                setState(() {
                  () => _selectedGender = 'Male';
                  _selectedIcon = FontAwesomeIcons.mars;
                });
                Navigator.pop(context);
              }),
              _buildBottomSheetItem(Icons.female, 'Female', Colors.pink, () {
                setState(() {
                  _selectedGender = 'Female';
                  _selectedIcon = FontAwesomeIcons.venus;
                });
                Navigator.pop(context);
              }),
              _buildBottomSheetItem(
                Icons.transgender,
                'Other ===> خول يعني',
                Colors.white,
                () {
                  setState(() {
                    _selectedGender = 'Other';
                    _selectedIcon = FontAwesomeIcons.transgender;
                  });
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 100.h),
            ],
          ),
        );
      },
    );
  }

  // Helper widget for bottom sheet options
  Widget _buildBottomSheetItem(IconData icon, String title, Color color,
      [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  void _showCupertinoDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Birthday",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.transparent,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    minimumYear: 1950,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => _selectedBirthday = newDate);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                ),
                child: Text("Confirm"),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Custom Selection Field Widget
class _CustomSelectionField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _CustomSelectionField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(value, style: TextStyle(color: Colors.white70)),
      leading: Icon(icon, color: Colors.white),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
      onTap: onTap,
    );
  }
}
