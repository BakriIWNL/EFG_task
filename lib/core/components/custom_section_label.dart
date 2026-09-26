import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomSectionLabel extends StatelessWidget {
  const CustomSectionLabel({
    super.key,
    required this.text,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.appTextStyles.labelSmall.copyWith(
        color: color ?? context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
