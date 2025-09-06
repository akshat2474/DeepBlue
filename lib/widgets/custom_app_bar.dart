import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSignUpPressed;

  const CustomAppBar({
    Key? key,
    this.onSearchPressed,
    this.onSignUpPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Your custom image in the top bar too
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search, 
                    color: AppColors.primaryWhite,
                    size: 22,
                  ),
                  onPressed: onSearchPressed ?? () {},
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16, 
                    vertical: 8
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
