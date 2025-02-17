import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/features/account/presentation/screens/account_screen.dart';
import 'package:chat_app/features/account/presentation/screens/change_email_screen.dart';
import 'package:chat_app/features/account/presentation/screens/change_username_screen.dart';
import 'package:chat_app/features/account/presentation/screens/profile_screen.dart';
import 'package:chat_app/features/account/presentation/screens/update_password_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/register_screen.dart';
import 'package:chat_app/features/chat/presentation/screens/chat_stream_screen.dart';
import 'package:chat_app/features/onboarding/onboarding_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:chat_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.authCheckScreen:
        return MaterialPageRoute(builder: (_) => const AuthCheckScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => const Chat());
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.accountScreen:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case Routes.changeUsernameScreen:
        return MaterialPageRoute(builder: (_) => const ChangeUsernameScreen());
      case Routes.changeEmailScreen:
        return MaterialPageRoute(builder: (_) => const ChangeEmailScreen());
      case Routes.updatePasswordScreen:
        return MaterialPageRoute(builder: (_) => const UpdatePasswordScreen());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }
}
