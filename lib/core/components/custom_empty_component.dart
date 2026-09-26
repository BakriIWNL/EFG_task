import 'package:animate_do/animate_do.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomEmptyComponent extends StatelessWidget {
  const CustomEmptyComponent({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox,
  });

  final String message;
  final String? title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomIn(
              duration: AppDurations.entrance,
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colorScheme.primaryContainer,
                      context.colorScheme.surfaceContainerHighest,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: AppShadows.soft(context.appTheme.shadow),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FadeInUp(
              from: AppSpacing.lg,
              duration: AppDurations.entrance,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: context.appTextStyles.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  Text(
                    message,
                    style: context.appTextStyles.bodyMedium.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
