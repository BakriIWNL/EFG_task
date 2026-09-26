part of '../screens/converter_screen.dart';

class BuildSwapButton extends StatefulWidget {
  const BuildSwapButton({
    super.key,
    required this.onTap,
    this.axis = Axis.vertical,
  });

  final VoidCallback? onTap;
  final Axis axis;

  @override
  State<BuildSwapButton> createState() => BuildSwapButtonState();
}

class BuildSwapButtonState extends State<BuildSwapButton> {
  double turns = 0;

  void onSwap() {
    setState(() => turns += 0.5);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onTap != null;
    return Tooltip(
      message: context.localizations.swapCurrencies,
      child: Semantics(
        button: true,
        enabled: isEnabled,
        child: AnimatedOpacity(
          opacity: isEnabled ? 1 : 0.4,
          duration: AppDurations.medium,
          child: AnimatedContainer(
            duration: AppDurations.medium,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isEnabled
                  ? AppShadows.glow(context.appTheme.emerald)
                  : const [],
            ),
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: context.colorScheme.primary,
              child: InkWell(
                onTap: isEnabled ? onSwap : null,
                child: SizedBox.square(
                  dimension: 48,
                  child: AnimatedRotation(
                    turns: turns,
                    duration: AppDurations.slow,
                    curve: Curves.easeOutBack,
                    child: Icon(
                      widget.axis == Axis.vertical
                          ? Icons.swap_vert_rounded
                          : Icons.swap_horiz_rounded,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
