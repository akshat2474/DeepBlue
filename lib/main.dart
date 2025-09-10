import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepBlue App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundBlack,
        primaryColor: Colors.white,
      ),
      home: const SplashScreen(), // Start with splash screen
      debugShowCheckedModeBanner: false,
    );
  }
}
