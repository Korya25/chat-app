import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/data/services/auth_repository.dart';
import 'package:chat_app/features/account/cubit/account_cubit.dart';
import 'package:chat_app/features/account/data/account_repositry.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepository())),
        BlocProvider(create: (context) => AccountCubit(AccountRepository())),
      ],
      child: child,
    );
  }
}
