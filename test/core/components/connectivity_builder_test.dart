import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/themes/app_theme_data.dart';
import 'package:efg_currency_converter/config/themes/flavors/flavors.dart';
import 'package:efg_currency_converter/core/components/connectivity_builder.dart';
import 'package:efg_currency_converter/core/components/no_network_component.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NetworkCubit networkCubit;

  setUp(() {
    networkCubit = NetworkCubit();
  });

  tearDown(() => networkCubit.close());

  Widget buildApp() {
    return BlocProvider.value(
      value: networkCubit,
      child: Builder(
        builder: (context) => MaterialApp(
          theme: LightTheme().createThemeData(context),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: ConnectivityBuilder(
              connectionWidget: SizedBox(width: double.infinity),
              noConnectionWidget: NoNetworkComponent(),
            ),
          ),
        ),
      ),
    );
  }

  group('ConnectivityBuilder', () {
    testWidgets('hides the strip while connected', (tester) async {
      networkCubit.updateConnectivity([ConnectivityResult.wifi]);
      await tester.pumpWidget(buildApp());

      expect(find.text('No internet detected'), findsNothing);
    });

    testWidgets('shows the red strip when the connection is lost',
        (tester) async {
      await tester.pumpWidget(buildApp());

      networkCubit.updateConnectivity([ConnectivityResult.none]);
      await tester.pumpAndSettle();

      expect(find.text('No internet detected'), findsOneWidget);
      final context = tester.element(find.byType(NoNetworkComponent));
      final strip = tester.widget<ColoredBox>(
        find.descendant(
          of: find.byType(NoNetworkComponent),
          matching: find.byType(ColoredBox),
        ),
      );
      expect(
        strip.color,
        Theme.of(context).extension<AppThemeData>()?.thunderbird,
      );
    });

    testWidgets('hides the strip again when the connection returns',
        (tester) async {
      networkCubit.updateConnectivity([ConnectivityResult.none]);
      await tester.pumpWidget(buildApp());
      expect(find.text('No internet detected'), findsOneWidget);

      networkCubit.updateConnectivity([ConnectivityResult.mobile]);
      await tester.pumpAndSettle();

      expect(find.text('No internet detected'), findsNothing);
    });
  });
}
