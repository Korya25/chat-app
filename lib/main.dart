import 'package:flutter/material.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/core/providers/app_providers.dart';
import 'package:chat_app/config/app_initializer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

void main() async {
  await AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: KeyboardDismisser(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AppRoutes.authCheck,
          ),
        ),
      ),
    );
  }
}
