import 'package:flutter/material.dart';

class FeatureItem {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const FeatureItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}
