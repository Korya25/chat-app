import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onFieldSubmitted;

  const UsernameField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: 'Username',
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: Validators.validateUsername,
      prefixIcon: const Icon(Icons.person_outline),
      keyboardType: TextInputType.text,
    );
  }
}
