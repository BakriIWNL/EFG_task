part of '../screens/converter_screen.dart';

class BuildConversionResult extends StatelessWidget {
  const BuildConversionResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
      buildWhen: (previous, current) =>
          previous.conversionState != current.conversionState ||
          previous.conversion != current.conversion,
      builder: (context, state) {
        final conversion = state.conversion;
        final Widget child;
        if (state.conversionState == GenericStates.loading) {
          child = const BuildResultPlaceholder(
            key: ValueKey('loading'),
            isLoading: true,
          );
        } else if (state.conversionState == GenericStates.success &&
            conversion != null) {
          child = BuildResultCard(
            key: ValueKey(conversion.id),
            conversion: conversion,
          );
        } else if (state.conversionState == GenericStates.error) {
          child = const BuildConversionErrorCard(key: ValueKey('error'));
        } else {
          child = const BuildResultPlaceholder(key: ValueKey('idle'));
        }

        return AnimatedSwitcher(
          duration: AppDurations.slow,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (currentChild, previousChildren) => Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.passthrough,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.94, end: 1).animate(animation),
              child: child,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
