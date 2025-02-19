import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_layout.dart';
import 'package:chat_app/features/auth/presentation/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/widgets/password_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.chat,
            (route) => false,
          );
          _emailController.clear();
          _passwordController.clear();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final errorMessage = state is AuthError ? state.message : '';
        return AuthLayout(
          title: 'Login',
          introTitle: 'Welcome back!',
          introSubtitle: 'Sign in to your account',
          formKey: _formKey,
          formFields: [
            EmailField(
              controller: _emailController,
              focusNode: _emailFocusNode,
            ),
            SizedBox(height: 16.h),
            PasswordField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              isPasswordVisible: _isPasswordVisible,
              onVisibilityPressed: () => setState(
                () => _isPasswordVisible = !_isPasswordVisible,
              ),
            ),
            SizedBox(height: 10.h),
          ],
          submitButtonText: 'Login',
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signIn(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim());

              /*    context.read<AuthCubit>().signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );*/
            }
          },
          isLoading: isLoading,
          errorMessage: errorMessage,
          showForgotPassword: true,
          onForgotPassword: () {
            context.read<AuthCubit>().clearError();
            Navigator.pushNamed(context, AppRoutes.forgotPassword);
          },
        );
      },
    );
  }
}
