import 'package:chat_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: CustomButton(
            borderRadius: 0,
            text: 'Sign Out',
            isLoading: false, //state is AuthLoading,
            onPressed: () {} //context.read<AuthCubit>().signOut(),
            ),
      ),
    );
  }
}
