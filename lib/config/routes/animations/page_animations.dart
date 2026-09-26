import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageAnimations {
  static CustomTransitionPage<void> fadeAnimationPage({
    required LocalKey pageKey,
    required Widget screen,
    String? name,
  }) {
    return CustomTransitionPage(
      key: pageKey,
      name: name,
      transitionDuration: AppDurations.fast,
      child: screen,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}
