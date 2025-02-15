import 'package:chat_app/core/router/routes.dart';
import 'package:chat_app/core/widget/custom_app_bar.dart';
import 'package:chat_app/core/widget/custom_button.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chats',
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.onboardingScreen,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return CustomButton(
              borderRadius: 0,
              text: 'Sign Out',
              isLoading: state is AuthLoading,
              onPressed: () => context.read<AuthCubit>().signOut(),
            );
          },
        ),
      ),
    );
  }
}
