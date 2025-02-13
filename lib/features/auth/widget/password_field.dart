import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityPressed;

  const PasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isPasswordVisible,
    required this.onVisibilityPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: 'Password',
      controller: controller,
      focusNode: focusNode,
      validator: Validators.validatePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: IconButton(
        onPressed: onVisibilityPressed,
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
      obscureText: !isPasswordVisible,
    );
  }
}
