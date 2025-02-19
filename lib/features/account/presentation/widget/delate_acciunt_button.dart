import 'package:chat_app/core/constant/app_colors.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/core/widget/custom_text_button.dart';
import 'package:chat_app/core/widget/custom_text_form_field.dart';
import 'package:chat_app/features/account/cubit/account_cubit.dart';
import 'package:chat_app/features/account/cubit/account_state.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: 'Delete Account',
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.red,
      ),
      onPressed: () {
        context.read<AccountCubit>().clearError();
        showDialog(
          context: context,
          builder: (_) => const DeleteAccountDialog(),
        );
      },
    );
  }
}

// Dialog to confirm account deletion
class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  bool _isEnabled = false;

  void _validatePassword(String value) {
    setState(() {
      _isEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  void _handleDeleteAccount(BuildContext context) {
    if (_isEnabled) {
      context
          .read<AccountCubit>()
          .deleteAccount(_passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AccountCubit>(context),
      child: AlertDialog(
        backgroundColor: AppColors.primaryColor,
        title: _buildTitle(),
        content: _buildContent(context),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Confirm Account Deletion',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildWarningText(),
              SizedBox(height: 20.h),
              _buildPasswordField(),
              if (_errorMessage != null) _buildErrorMessage(),
              SizedBox(height: 10.h),
              _buildActionButtons(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWarningText() {
    return Text(
      'Are you sure you want to delete your account? This action cannot be reversed. Enter your password to confirm.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormField(
      controller: _passwordController,
      hintText: 'Enter your password',
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
      ),
      fillColor: Colors.white24,
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: Validators.validatePassword,
      onChanged: _validatePassword,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      _errorMessage!,
      style: TextStyle(
        color: Colors.red,
        fontSize: 14.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountSuccess) {
          context.read<AuthCubit>().signOut();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.authCheck);
        } else if (state is AccountError) {
          setState(() => _errorMessage = state.error);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomButton(
              color: _isEnabled ? Colors.red : Colors.grey[400]!,
              onPressed: () => _handleDeleteAccount(context),
              text: 'Delete',
              isLoading: state is AccountLoading,
            ),
            SizedBox(height: 5.h),
            CustomButton(
              color: Colors.green,
              onPressed: () => Navigator.pop(context),
              text: 'Cancel',
            ),
          ],
        );
      },
    );
  }
}
