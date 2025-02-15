import 'package:chat_app/features/settings/presentation/sections/account_section.dart';
import 'package:chat_app/features/settings/presentation/sections/help_section.dart';
import 'package:chat_app/features/settings/presentation/sections/logout_button.dart';
import 'package:chat_app/features/settings/presentation/sections/preferences_section.dart';
import 'package:chat_app/features/settings/presentation/widgets/follow_us_section.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/widget/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: const SettingsBody(),
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        AccountSection(),
        PreferencesSection(),
        HelpSection(),
        FollowUsSection(),
        LogoutButton(),
      ],
    );
  }
}
