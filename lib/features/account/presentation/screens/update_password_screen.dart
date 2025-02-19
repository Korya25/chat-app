import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_form_field.dart';
import 'package:chat_app/features/account/cubit/account_cubit.dart';
import 'package:chat_app/features/account/cubit/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool oldPasswordvisable = false;
  bool newPasswordvisable = false;

  void _updatePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().updatePassword(
            _oldPasswordController.text.trim(),
            _newPasswordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Password")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: _oldPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    oldPasswordvisable
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      oldPasswordvisable = !oldPasswordvisable;
                    });
                  },
                ),
                hintText: "Enter old password",
                obscureText: !oldPasswordvisable,
                validator: (value) =>
                    value!.isEmpty ? "Old password is required" : null,
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: _newPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    newPasswordvisable
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      newPasswordvisable = !newPasswordvisable;
                    });
                  },
                ),
                hintText: "Enter new password",
                obscureText: !newPasswordvisable,
                validator: (value) => value!.length < 6
                    ? "Password must be at least 6 characters"
                    : null,
              ),
              SizedBox(height: 20.h),
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) {
                  if (state is AccountPasswordUpdated) {
                    // alert dialog to show success message
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Password updated successfully"),
                              actions: [
                                CustomButton(
                                  text: "OK",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                  } else if (state is AccountError) {
                    // show error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(state.error),
                        actions: [
                          CustomButton(
                            text: "OK",
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AccountCubit>().clearError();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: "Update Password",
                    isLoading: state is AccountLoading,
                    onPressed: () => _updatePassword(context),
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
