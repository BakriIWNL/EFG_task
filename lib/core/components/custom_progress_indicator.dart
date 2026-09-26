import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    this.color,
    this.strokeWidth = 2.8,
  });

  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? context.colorScheme.primary,
      strokeWidth: strokeWidth,
      strokeCap: StrokeCap.round,
    );
  }
}
