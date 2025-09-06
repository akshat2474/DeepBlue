import 'package:flutter/material.dart';
import '../widgets/starfield_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/deep_blue_logo_section.dart';
import '../widgets/bottom_input_section.dart';
import '../constants/app_colors.dart';

class DeepBlueHomePage extends StatefulWidget {
  const DeepBlueHomePage({super.key});

  @override
  State<DeepBlueHomePage> createState() => _DeepBlueHomePageState();
}

class _DeepBlueHomePageState extends State<DeepBlueHomePage> {
  final TextEditingController _inputController = TextEditingController();
  bool _hasInput = false; // Track if user has typed something
  String _dummyResponse = "";

  @override
  void initState() {
    super.initState();
    // Listen for text changes
    _inputController.addListener(() {
      setState(() {
        _hasInput = _inputController.text.isNotEmpty;
        if (_hasInput && _dummyResponse.isEmpty) {
          // Show dummy response when user starts typing
          _dummyResponse = "I'm DeepBlue AI, here to help you with your questions! "
                          "This is a dummy response to show how the interface changes "
                          "when you start typing. I can assist with research, creative tasks, "
                          "and much more. What would you like to know?";
        } else if (!_hasInput) {
          _dummyResponse = "";
        }
      });
    });
  }


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
          
          // Main content - show logo/buttons OR response
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _hasInput 
                ? _buildResponseView() 
                : _buildHomeView(),
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

  // Original home view with logo and buttons
  Widget _buildHomeView() {
    return Column(
      key: const ValueKey('homeView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const DeepBlueLogoSection(),
        const SizedBox(height: 15),
      ],
    );
  }

  // Response view when user types
  Widget _buildResponseView() {
    return Container(
      key: const ValueKey('responseView'),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User input display
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundBlack,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  color: AppColors.primaryWhite,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _inputController.text,
                    style: const TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // AI Response
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primaryWhite,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.smart_toy,
                  color: AppColors.primaryBlack,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _dummyResponse,
                  style: const TextStyle(
                    color: AppColors.primaryWhite,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Callback methods
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
