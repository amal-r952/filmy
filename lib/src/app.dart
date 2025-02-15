import 'package:filmy/src/screens/user_list_screen.dart';
import 'package:filmy/src/theme/app_theme/app_theme_data.dart';
import 'package:filmy/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.bottomNavigationBg,
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: AppThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      themeMode: ThemeMode.system,
      home: UserListScreen(),
    );
  }
}
