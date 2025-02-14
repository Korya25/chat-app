import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    final authCubit = context.read<AuthCubit>();
    authCubit.checkUserStatus();

    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      final state = context.read<AuthCubit>().state;
      if (state is AuthSuccess) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.chatScreen);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
