import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PersonasDropdown extends StatelessWidget {
  final VoidCallback? onPressed;

  const PersonasDropdown({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16, 
          vertical: 12
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_outline,
              color: AppColors.primaryWhite,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Personas',
              style: AppTextStyles.personasText,
            ),
            SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryWhite,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
