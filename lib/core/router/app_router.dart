import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'package:chat_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:chat_app/features/onboarding/onboarding_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/register_screen.dart';
import 'package:chat_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chat_app/features/chat/presentation/screens/chat_stream_screen.dart';
import 'package:chat_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:chat_app/features/account/presentation/screens/profile_screen.dart';
import 'package:chat_app/features/account/presentation/screens/account_screen.dart';
import 'package:chat_app/features/account/presentation/screens/change_username_screen.dart';
import 'package:chat_app/features/account/presentation/screens/change_email_screen.dart';
import 'package:chat_app/features/account/presentation/screens/update_password_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget Function(BuildContext) builder = _routes[settings.name] ??
        (context) =>
            const OnboardingScreen(); // Default route when no route is found

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }

  static final Map<String, Widget Function(BuildContext)> _routes = {
    AppRoutes.authCheck: (_) => const AuthCheckScreen(),
    AppRoutes.onboarding: (_) => const OnboardingScreen(),
    AppRoutes.login: (_) => const LoginScreen(),
    AppRoutes.register: (_) => const SignupScreen(),
    AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
    AppRoutes.chat: (_) => const Chat(),
    AppRoutes.settings: (_) => const SettingsScreen(),
    AppRoutes.profile: (_) => const ProfileScreen(),
    AppRoutes.account: (_) => const AccountScreen(),
    AppRoutes.changeUsername: (_) => const ChangeUsernameScreen(),
    AppRoutes.changeEmail: (_) => const ChangeEmailScreen(),
    AppRoutes.updatePassword: (_) => const UpdatePasswordScreen(),
  };
}
