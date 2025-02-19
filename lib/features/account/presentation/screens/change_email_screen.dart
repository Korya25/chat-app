import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_form_feild.dart';
import 'package:chat_app/features/account/cubit/account_cubit.dart';
import 'package:chat_app/features/account/cubit/account_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Email")),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: emailController,
                hintText: "New Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              CustomTextFormField(
                controller: passwordController,
                hintText: "Current Password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Enter your password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) {
                  if (state is AccountSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pop(context);
                  } else if (state is AccountError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: "Update Email",
                    isLoading: state is AccountLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AccountCubit>().processEmailUpdate(
                              emailController.text.trim(),
                              passwordController.text.trim(),
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
