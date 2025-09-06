import 'package:flutter/material.dart';
import '../widgets/starfield_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/deepBlue_logo_section.dart';
import '../widgets/bottom_input_section.dart';
import '../constants/app_colors.dart';

class DeepBlueHomePage extends StatefulWidget {
  const DeepBlueHomePage({super.key});

  @override
  State<DeepBlueHomePage> createState() => _DeepBlueHomePageState();
}

class _DeepBlueHomePageState extends State<DeepBlueHomePage> {
  final TextEditingController _inputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      body: Stack(
        children: [
          // Animated starfield background
          const AnimatedStarfieldBackground(),

          // Top navigation bar
          CustomAppBar(
            onSearchPressed: _onSearchPressed,
            onSignUpPressed: _onSignUpPressed,
          ),

          // Main content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DeepBlueLogoSection(),
                const SizedBox(height: 0), // Change from 40 to 20 (or less)
              ],
            ),
          ),

          // Bottom input section
          BottomInputSection(
            controller: _inputController,
            onMicPressed: _onMicPressed,
            onAttachmentPressed: _onAttachmentPressed,
            onAutoPressed: _onAutoPressed,
            onTermsPressed: _onTermsPressed,
            onPrivacyPressed: _onPrivacyPressed,
          ),
        ],
      ),
    );
  }

  // Callback methods (same as before)
  void _onSearchPressed() => print('Search pressed');
  void _onSignUpPressed() => print('Sign up pressed');
  void _onMicPressed() => print('Microphone pressed');
  void _onAttachmentPressed() => print('Attachment pressed');
  void _onAutoPressed() => print('Auto dropdown pressed');
  void _onTermsPressed() => print('Terms pressed');
  void _onPrivacyPressed() => print('Privacy Policy pressed');

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
