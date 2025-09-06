import 'package:flutter/material.dart';
import 'screens/deepBlue_home_page.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepBlue',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundBlack,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.grey,
          surface: AppColors.cardBackground,
        ),
      ),
      home: const DeepBlueHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
