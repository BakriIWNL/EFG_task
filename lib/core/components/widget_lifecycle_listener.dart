import 'package:flutter/material.dart';

class WidgetLifecycleListener extends StatefulWidget {
  const WidgetLifecycleListener({
    super.key,
    this.onInit,
    this.onDispose,
    this.child,
  });

  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final Widget? child;

  @override
  State<WidgetLifecycleListener> createState() =>
      WidgetLifecycleListenerState();
}

class WidgetLifecycleListenerState extends State<WidgetLifecycleListener> {
  @override
  void initState() {
    widget.onInit?.call();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
