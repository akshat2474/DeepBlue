import 'package:flutter/material.dart';
import '../widgets/starfield_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/grok_logo_section.dart';
import '../widgets/bottom_input_section.dart';
import '../models/feature_item.dart';
import '../constants/app_colors.dart';

class GrokHomePage extends StatefulWidget {
  const GrokHomePage({Key? key}) : super(key: key);

  @override
  State<GrokHomePage> createState() => _GrokHomePageState();
}

class _GrokHomePageState extends State<GrokHomePage> {
  final TextEditingController _inputController = TextEditingController();

  List<FeatureItem> get _features => [
    FeatureItem(
      icon: Icons.search,
      label: 'DeepSearch',
      onPressed: _onDeepSearchPressed,
    ),
    FeatureItem(
      icon: Icons.image_outlined,
      label: 'Create Images',
      onPressed: _onCreateImagesPressed,
    ),
    FeatureItem(
      icon: Icons.science_outlined,
      label: 'Research',
      onPressed: _onResearchPressed,
    ),
    FeatureItem(
      icon: Icons.feed_outlined,
      label: 'Latest News',
      onPressed: _onLatestNewsPressed,
    ),
  ];

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
                // Grok logo and title
                const GrokLogoSection(),
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
  void _onDeepSearchPressed() => print('DeepSearch pressed');
  void _onCreateImagesPressed() => print('Create Images pressed');
  void _onResearchPressed() => print('Research pressed');
  void _onLatestNewsPressed() => print('Latest News pressed');
  void _onPersonasPressed() => print('Personas pressed');
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
