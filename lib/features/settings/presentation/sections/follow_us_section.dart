import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUsSection extends StatelessWidget {
  const FollowUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Center(
          child: Text(
            'Follow Us @chat_app',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: FontAwesomeIcons.instagram,
              url: 'https://www.instagram.com/ko_ry_a1',
              color: Colors.pink,
            ),
            _buildSocialButton(
              icon: FontAwesomeIcons.youtube,
              url: 'https://www.youtube.com/@K_or_y',
              color: Colors.red,
            ),
            _buildSocialButton(
              icon: FontAwesomeIcons.tiktok,
              url: 'https://www.tiktok.com/@korya9',
              color: Colors.black,
            ),
            _buildSocialButton(
              icon: FontAwesomeIcons.facebook,
              url: 'https://www.facebook.com/Korya8',
              color: Colors.blue,
            ),
            _buildSocialButton(
              icon: FontAwesomeIcons.x,
              url: 'https://twitter.com/Korya8',
              color: Colors.black,
            ),
            _buildSocialButton(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/Korya25',
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    Color? color,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(icon, color: color, size: 30.sp),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
