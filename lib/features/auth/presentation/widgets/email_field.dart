import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const EmailField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: 'Email',
      controller: controller,
      focusNode: focusNode,
      validator: Validators.validateEmail,
      prefixIcon: const Icon(Icons.email_outlined),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
