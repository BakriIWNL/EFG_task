import 'package:efg_currency_converter/config/routes/app_router.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSuccess(
    BuildContext? context,
    String? message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final BuildContext ctx = context ?? AppRouter.ctx;
    ScaffoldMessenger.of(ctx)
      ..clearSnackBars()
      ..showSnackBar(
        _buildSnackBar(
          context: ctx,
          message: message,
          icon: Icons.check_circle_outline,
          backgroundColor: ctx.appTheme.pineMist,
          borderColor: ctx.appTheme.pine,
          messageColor: ctx.appTheme.pineDeep,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      );
  }

  static void showProblem(
    BuildContext? context,
    String? message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final BuildContext ctx = context ?? AppRouter.ctx;
    ScaffoldMessenger.of(ctx)
      ..clearSnackBars()
      ..showSnackBar(
        _buildSnackBar(
          context: ctx,
          message: message,
          icon: Icons.warning_amber_rounded,
          backgroundColor: ctx.appTheme.amberMist,
          borderColor: ctx.appTheme.amber,
          messageColor: ctx.appTheme.amberDeep,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      );
  }

  static void showError(
    BuildContext? context,
    String? message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final BuildContext ctx = context ?? AppRouter.ctx;
    ScaffoldMessenger.of(ctx)
      ..clearSnackBars()
      ..showSnackBar(
        _buildSnackBar(
          context: ctx,
          message: message,
          icon: Icons.error_outline,
          backgroundColor: ctx.appTheme.dangerMist,
          borderColor: ctx.appTheme.danger,
          messageColor: ctx.appTheme.dangerDeep,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      );
  }
}

SnackBar _buildSnackBar({
  required BuildContext context,
  String? message,
  required IconData icon,
  required Color backgroundColor,
  required Color borderColor,
  required Color messageColor,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: BorderSide(color: borderColor),
    ),
    content: Row(
      children: [
        Icon(icon, size: 22, color: messageColor),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            message ?? '',
            style: context.appTextStyles.bodyMedium.copyWith(
              color: messageColor,
            ),
          ),
        ),
      ],
    ),
    action: actionLabel != null && onAction != null
        ? SnackBarAction(
            label: actionLabel,
            textColor: messageColor,
            onPressed: onAction,
          )
        : null,
  );
}
