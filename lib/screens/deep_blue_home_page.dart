import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import the new service
import '../widgets/starfield_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/deep_blue_logo_section.dart';
import '../widgets/bottom_input_section.dart';
import '../constants/app_colors.dart';
import 'package:flutter/services.dart'; // For clipboard

class DeepBlueHomePage extends StatefulWidget {
  const DeepBlueHomePage({super.key});

  @override
  State<DeepBlueHomePage> createState() => _DeepBlueHomePageState();
}

class _DeepBlueHomePageState extends State<DeepBlueHomePage> {
  final TextEditingController _inputController = TextEditingController();
  final ApiService _apiService = ApiService();

  // State variables to manage the UI
  String _userQuery = "";
  String _apiResponse = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      // This listener can be used for real-time validation if needed
      setState(() {});
    });
  }

  /// Handles sending the user's query to the backend API.
  void _sendMessage() async {
    final String query = _inputController.text;
    if (query.isEmpty) return;

    // Set the state to show the loading indicator and user's query
    setState(() {
      _isLoading = true;
      _userQuery = query;
      _apiResponse = ""; // Clear previous response
    });

    // Clear the input field
    _inputController.clear();

    // Call the API service
    final response = await _apiService.sendMessage(query);

    // Update the state with the API's response
    setState(() {
      _apiResponse = response;
      _isLoading = false;
    });
  }

  /// Resets the chat interface to the initial state.
  void _resetChat() {
    setState(() {
      _userQuery = "";
      _apiResponse = "";
      _isLoading = false;
      _inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we should show the initial home view or the chat/response view
    final bool showResponseView = _userQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      body: Stack(
        children: [
          const AnimatedStarfieldBackground(),
          CustomAppBar(
            onSearchPressed: () {}, // Implement search if needed
            onSignUpPressed: () {}, // Implement sign-up if needed
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: showResponseView
                  ? _buildResponseView()
                  : _buildHomeView(),
            ),
          ),
          BottomInputSection(
            controller: _inputController,
            // The microphone button now sends the message
            onMicPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  /// The initial view with the logo.
  Widget _buildHomeView() {
    return const Column(
      key: ValueKey('homeView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        DeepBlueLogoSection(),
        SizedBox(height: 15),
      ],
    );
  }

  /// The view that shows the user's query and the AI's response.
  Widget _buildResponseView() {
    return Container(
      key: const ValueKey('responseView'),
      margin: const EdgeInsets.fromLTRB(20, 80, 20, 180), // Adjust margins
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User query display
            _buildQuerySection(),
            const SizedBox(height: 20),
            // AI response display
            _buildAIResponseSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuerySection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.person, color: AppColors.primaryWhite, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _userQuery,
              style: const TextStyle(color: AppColors.primaryWhite, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIResponseSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.primaryWhite,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.smart_toy,
            color: AppColors.primaryBlack,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _isLoading
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _apiResponse,
                      style: const TextStyle(
                          color: AppColors.primaryWhite, fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 15),
                    // Action buttons (Reset and Copy)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh, color: AppColors.greyText),
                          onPressed: _resetChat,
                          tooltip: 'Ask new question',
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: AppColors.greyText),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _apiResponse));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Response copied to clipboard!')),
                            );
                          },
                          tooltip: 'Copy response',
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
