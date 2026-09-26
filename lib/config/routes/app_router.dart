import 'package:efg_currency_converter/config/routes/animations/page_animations.dart';
import 'package:efg_currency_converter/config/routes/app_routes.dart';
import 'package:efg_currency_converter/features/converter/converter_service_locator.dart';
import 'package:efg_currency_converter/features/converter/presentation/controllers/converter_cubit.dart';
import 'package:efg_currency_converter/features/history/history_service_locator.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:efg_currency_converter/features/home/home_service_locator.dart';
import 'package:efg_currency_converter/features/home/presentation/controllers/nav_bar_cubit.dart';
import 'package:efg_currency_converter/features/home/presentation/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

mixin AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static BuildContext get ctx => rootNavigatorKey.currentState!.context;

  static String _extractRouteName(String route) {
    final parts = route.split('/').where((s) => s.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.last : 'root';
  }

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        name: _extractRouteName(AppRoutes.home),
        path: AppRoutes.home,
        pageBuilder: (context, state) {
          return PageAnimations.fadeAnimationPage(
            pageKey: state.pageKey,
            name: state.name ?? state.matchedLocation,
            screen: MultiBlocProvider(
              providers: [
                BlocProvider<NavBarCubit>(
                  create: (_) => HomeServiceLocator.instance<NavBarCubit>(),
                ),
                BlocProvider<ConverterCubit>(
                  create: (_) =>
                      ConverterServiceLocator.instance<ConverterCubit>()
                        ..getCurrencies(),
                ),
                BlocProvider<HistoryCubit>(
                  create: (_) => HistoryServiceLocator.instance<HistoryCubit>()
                    ..getHistory(),
                ),
              ],
              child: const NavBarScreen(),
            ),
          );
        },
      ),
    ],
  );
}
