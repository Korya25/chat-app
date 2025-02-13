import 'package:chat_app/features/auth/screen/auth_screen.dart';
import 'package:chat_app/features/auth/widget/email_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Forgot Password',
      introTitle: 'Enter your email',
      introSubtitle:
          'Dont Warry We will send you a code to reset your password',
      formKey: _formKey,
      formFields: [
        EmailField(
          controller: _emailController,
          focusNode: _emailFocusNode,
        ),
      ],
      submitButtonText: 'Send',
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          /*  context.read<AuthCubit>().resetPassword(
                email: _emailController.text,
              );*/
        }
      },
      isLoading: false,
      errorMessage: '',
    );
  }
}
