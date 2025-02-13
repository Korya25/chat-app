import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/features/auth/screen/forgot_password_screen.dart';
import 'package:chat_app/features/auth/screen/login_screen.dart';
import 'package:chat_app/features/auth/screen/register_screen.dart';
import 'package:chat_app/features/onboarding/chat.dart';
import 'package:chat_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          ),
        );
    }
  }
}
