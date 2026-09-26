import 'package:animate_do/animate_do.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/custom_button.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({
    super.key,
    this.errorMessage,
    this.onTap,
  });

  final String? errorMessage;
  final VoidCallback? onTap;

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
                  color: context.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: AppShadows.soft(context.colorScheme.error),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 44,
                  color: context.colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FadeInUp(
              from: AppSpacing.lg,
              duration: AppDurations.entrance,
              child: Text(
                errorMessage ?? context.localizations.somethingWentWrong,
                style: context.appTextStyles.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              FadeInUp(
                from: AppSpacing.lg,
                duration: AppDurations.entrance,
                child: CustomButton.outlined(
                  text: context.localizations.retry,
                  icon: Icons.refresh_rounded,
                  height: 48,
                  onTap: onTap,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
