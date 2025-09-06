import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle deepBlueTitle = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 44,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  static const TextStyle featureButtonText = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle personasText = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle inputHint = TextStyle(
    color: AppColors.greyText,
    fontSize: 16,
  );

  static const TextStyle inputText = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 16,
  );

  static const TextStyle autoText = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle termsText = TextStyle(
    color: AppColors.greyText,
    fontSize: 12,
  );

  static const TextStyle underlinedText = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: AppColors.greyText,
  );
}
