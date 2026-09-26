import 'package:animate_do/animate_do.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/custom_progress_indicator.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
  }) : isOutlined = false,
       isText = false;

  const CustomButton.outlined({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.width,
    this.height,
    this.textColor,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
  }) : isOutlined = true,
       isText = false,
       backgroundColor = null;

  const CustomButton.text({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.textColor,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
  }) : isOutlined = false,
       isText = true,
       width = null,
       height = 44,
       backgroundColor = null;

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isEnabled;
  final bool isOutlined;
  final bool isText;

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isEnabled && widget.onTap != null;
    final isFilled = !widget.isOutlined && !widget.isText;
    final fillColor = isFilled
        ? widget.backgroundColor ?? context.colorScheme.primary
        : Colors.transparent;
    final foregroundColor =
        widget.textColor ??
        (isFilled
            ? context.colorScheme.onPrimary
            : context.colorScheme.primary);
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: (widget.textStyle ?? context.appTextStyles.labelLarge)
                .copyWith(color: foregroundColor),
          ),
        ),
        if (widget.icon != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Icon(widget.icon, size: 20, color: foregroundColor),
        ],
      ],
    );

    return AnimatedScale(
      scale: isPressed ? 0.96 : 1,
      duration: AppDurations.fast,
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: isActive || widget.isLoading ? 1 : 0.4,
        duration: AppDurations.medium,
        child: AnimatedContainer(
          duration: AppDurations.medium,
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height ?? 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            boxShadow: isFilled && isActive && !widget.isLoading
                ? AppShadows.glow(fillColor)
                : const [],
          ),
          child: Material(
            color: fillColor,
            clipBehavior: Clip.antiAlias,
            shape: StadiumBorder(
              side: widget.isOutlined
                  ? BorderSide(color: context.colorScheme.outline)
                  : BorderSide.none,
            ),
            child: InkWell(
              onTap: isActive && !widget.isLoading ? widget.onTap : null,
              onHighlightChanged: (value) => setState(() => isPressed = value),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: widget.isLoading ? 0 : 1,
                      duration: AppDurations.fast,
                      child: content,
                    ),
                    if (widget.isLoading)
                      FadeIn(
                        duration: AppDurations.fast,
                        child: SizedBox.square(
                          dimension: 22,
                          child: CustomProgressIndicator(
                            color: foregroundColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
