import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBuilder extends StatelessWidget {
  const ConnectivityBuilder({
    super.key,
    required this.connectionWidget,
    required this.noConnectionWidget,
  });

  final Widget connectionWidget;
  final Widget noConnectionWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, InternetState>(
      builder: (context, state) {
        final isOffline = state == InternetState.offState;
        return AnimatedSwitcher(
          duration: AppDurations.slow,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (currentChild, previousChildren) => Stack(
            alignment: Alignment.topCenter,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            alignment: Alignment.topCenter,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: KeyedSubtree(
            key: ValueKey(isOffline),
            child: isOffline ? noConnectionWidget : connectionWidget,
          ),
        );
      },
    );
  }
}
