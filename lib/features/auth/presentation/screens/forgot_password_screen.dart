import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/auth_layout.dart';
import 'package:chat_app/features/auth/presentation/widgets/email_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSuccess) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Password Reset'),
              content: const Text('Password reset link sent to your email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _emailController.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          _emailController.clear();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final errorMessage =
            state is AuthPasswordResetError ? state.message : '';

        return AuthLayout(
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
              context
                  .read<AuthCubit>()
                  .resetPassword(email: _emailController.text.trim());
            }
          },
          isLoading: isLoading,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
