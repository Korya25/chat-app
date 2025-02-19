import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/features/account/cubit/account_cubit.dart';
import 'package:chat_app/features/account/cubit/account_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({super.key});

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage; // Store error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Username")),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: usernameController,
                hintText: "New Username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your new username";
                  }
                  if (value.length < 3) {
                    return "Username must be at least 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) {
                  if (state is AccountSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Username updated successfully!")),
                    );
                    Navigator.pop(context); // Navigate back after success
                  } else if (state is AccountError) {
                    setState(() {
                      errorMessage = state.error;
                    });
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: "Update Username",
                    isLoading: state is AccountLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          errorMessage = null;
                        });

                        context.read<AccountCubit>().changeUsername(
                              usernameController.text.trim(),
                            );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
