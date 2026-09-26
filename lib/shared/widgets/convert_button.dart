import 'package:efg_currency_converter/core/components/custom_button.dart';
import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isCompact = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      icon: Icons.currency_exchange_rounded,
      onTap: onTap,
      isLoading: isLoading,
      width: isCompact ? null : double.infinity,
      height: isCompact ? 40 : 56,
    );
  }
}
