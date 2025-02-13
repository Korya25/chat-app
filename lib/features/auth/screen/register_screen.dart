import 'package:chat_app/features/auth/screen/auth_screen.dart';
import 'package:chat_app/features/auth/widget/email_field.dart';
import 'package:chat_app/features/auth/widget/password_field.dart';
import 'package:chat_app/features/auth/widget/username_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Sign Up',
      introTitle: 'Create an account',
      introSubtitle: 'Fill in the form below to create an account',
      formKey: _formKey,
      formFields: [
        UsernameField(
          controller: _usernameController,
          focusNode: _usernameFocusNode,
        ),
        const SizedBox(height: 16),
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
      ],
      submitButtonText: 'Sign up',
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          /*  context.read<AuthCubit>().signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                  );*/
        }
      },
      showForgotPassword: false,
      isLoading: false,
      errorMessage: '',
    );
  }
}
