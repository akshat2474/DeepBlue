import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';

class GrokLogoSection extends StatelessWidget {
  const GrokLogoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/finlaldl.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain, // Changed to contain to show full logo
            ),
          ),
        ),
        // Use Transform.translate to pull the text up
        Transform.translate(
          offset: const Offset(0, -65), // Pull text even closer
          child: const Text('DeepBlue', style: AppTextStyles.grokTitle),
        ),
      ],
    );
  }
}
