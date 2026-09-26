import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/routes/app_router.dart';
import 'package:efg_currency_converter/config/themes/app_theme_builder.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:efg_currency_converter/core/controllers/theme_controller.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:efg_currency_converter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeController>(
          create: (_) => ServiceLocator.instance<ThemeController>(),
        ),
        BlocProvider<NetworkCubit>(
          lazy: false,
          create: (_) => ServiceLocator.instance<NetworkCubit>(),
        ),
      ],
      child: AppThemeBuilder(
        builder: (theme) {
          return MaterialApp.router(
            onGenerateTitle: (context) => context.localizations.appTitle,
            theme: theme,
            routerConfig: AppRouter.router,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
