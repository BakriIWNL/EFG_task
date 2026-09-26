import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

mixin UiAlerts {
  static Future<void> customDialog(
    BuildContext context, {
    required VoidCallback? onAction,
    VoidCallback? onCancel,
    String? title,
    required String content,
    required String action,
    required String cancel,
    bool isDestructive = false,
    bool isDisplayCancel = true,
  }) async {
    await showCupertinoDialog<void>(
      barrierDismissible: isDisplayCancel,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null ? null : Text(title),
          content: Text(content),
          actions: [
            if (isDisplayCancel)
              CupertinoDialogAction(
                onPressed: onCancel ?? () => context.pop(),
                child: Text(cancel),
              ),
            CupertinoDialogAction(
              isDestructiveAction: isDestructive,
              onPressed: onAction,
              child: Text(action),
            ),
          ],
        );
      },
    );
  }
}
