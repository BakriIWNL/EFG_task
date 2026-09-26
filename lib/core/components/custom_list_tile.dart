import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/custom_card.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.footer,
    this.onTap,
    this.isSelected = false,
    this.isElevated = false,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: isElevated
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle.merge(
                    style: context.appTextStyles.titleMedium,
                    child: title,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    DefaultTextStyle.merge(
                      style: context.appTextStyles.bodySmall.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              trailing!,
            ],
          ],
        ),
        if (footer != null) ...[
          const SizedBox(height: AppSpacing.sm),
          footer!,
        ],
      ],
    );

    if (isElevated) {
      return CustomCard(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.md,
        ),
        onTap: onTap,
        child: content,
      );
    }

    return AnimatedContainer(
      duration: AppDurations.medium,
      curve: Curves.easeOutCubic,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.primaryContainer
            : context.colorScheme.primaryContainer.withValues(alpha: 0),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
