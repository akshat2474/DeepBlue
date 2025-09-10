import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class BottomInputSection extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onMicPressed;
  final VoidCallback? onSendPressed; // New: Callback for the send button
  final bool hasText; // New: To control which button to show
  final VoidCallback? onAttachmentPressed;
  final VoidCallback? onAutoPressed;
  final VoidCallback? onTermsPressed;
  final VoidCallback? onPrivacyPressed;

  const BottomInputSection({
    super.key,
    this.controller,
    this.onMicPressed,
    this.onSendPressed,
    this.hasText = false, // Default to false
    this.onAttachmentPressed,
    this.onAutoPressed,
    this.onTermsPressed,
    this.onPrivacyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Attachment icon
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                      icon: const Icon(
                        Icons.attachment_outlined,
                        color: AppColors.primaryWhite,
                        size: 20,
                      ),
                      onPressed: onAttachmentPressed ?? () {},
                    ),
                  ),
                  // Text input
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: 'What do you want to know?',
                        hintStyle: AppTextStyles.inputHint,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                      ),
                      maxLines: null,
                      minLines: 1,
                      onSubmitted: (_) => onSendPressed?.call(), // Allow sending with keyboard
                    ),
                  ),
                  // Auto dropdown
                  GestureDetector(
                    onTap: onAutoPressed ?? () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Auto',
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.primaryWhite,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Conditionally show Send or Mic button
                  if (hasText)
                    // Show Send button if there is text
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: AppColors.primaryWhite,
                        ),
                        onPressed: onSendPressed,
                        tooltip: 'Send message',
                      ),
                    )
                  else
                    // Show Microphone button if there is no text
                    GestureDetector(
                      onTap: onMicPressed ?? () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryWhite,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: AppColors.primaryBlack,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Terms text
            Text.rich(
              TextSpan(
                style: AppTextStyles.termsText,
                children: [
                  const TextSpan(text: 'By messaging DeepBlue, you agree to our '),
                  TextSpan(
                    text: 'Terms',
                    style: AppTextStyles.termsText.merge(
                      AppTextStyles.underlinedText,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: AppTextStyles.termsText.merge(
                      AppTextStyles.underlinedText,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }
}
