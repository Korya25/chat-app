import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/features/auth/screen/auth_screen.dart';
import 'package:chat_app/features/auth/widget/email_field.dart';
import 'package:chat_app/features/auth/widget/password_field.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Login',
      introTitle: 'Welcome back!',
      introSubtitle: 'Sign in to your account',
      formKey: _formKey,
      formFields: [
        EmailField(
          controller: _emailController,
          focusNode: _emailFocusNode,
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          isPasswordVisible: _isPasswordVisible,
          onVisibilityPressed: () => setState(
            () => _isPasswordVisible = !_isPasswordVisible,
          ),
        ),
        const SizedBox(height: 10),
      ],
      submitButtonText: 'Login',
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          /*    context.read<AuthCubit>().signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );*/
        }
      },
      isLoading: false,
      errorMessage: '',
      showForgotPassword: true,
      onForgotPassword: () {
        //  context.read<AuthCubit>().clearError();
        Navigator.pushNamed(context, Routes.forgotPasswordScreen);
      },
    );
  }
}
