import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_layout.dart';
import 'package:chat_app/features/auth/presentation/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/widgets/username_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _userNameFocusNode.dispose();
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
          _userNameController.clear();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final errorMessage = state is AuthError ? state.message : '';
        return AuthLayout(
          title: 'Sign Up',
          introTitle: 'Create an account',
          introSubtitle: 'Fill in the form below to create an account',
          formKey: _formKey,
          formFields: [
            UsernameField(
              controller: _userNameController,
              focusNode: _userNameFocusNode,
            ),
            SizedBox(height: 16.h),
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
          ],
          submitButtonText: 'Sign up',
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signUp(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                  userName: _userNameController.text.trim());

              /*  context.read<AuthCubit>().signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                  );*/
            }
          },
          showForgotPassword: false,
          isLoading: isLoading,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
