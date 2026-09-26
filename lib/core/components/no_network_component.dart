import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class NoNetworkComponent extends StatelessWidget {
  const NoNetworkComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: ColoredBox(
        color: context.appTheme.thunderbird,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 18,
                  color: context.appTheme.white,
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    context.localizations.noInternetDetected,
                    style: context.appTextStyles.labelLarge.copyWith(
                      color: context.appTheme.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
