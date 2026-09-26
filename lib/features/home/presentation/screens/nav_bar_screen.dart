import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:efg_currency_converter/features/converter/presentation/screens/converter_screen.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:efg_currency_converter/features/history/presentation/screens/history_screen.dart';
import 'package:efg_currency_converter/features/home/presentation/controllers/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widgets/build_brand_mark.dart';
part '../widgets/build_nav_bar.dart';
part '../widgets/build_nav_bar_body.dart';
part '../widgets/build_nav_rail.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavBarCubit, int>(
      listener: (context, index) {
        if (index == NavBarCubit.historyIndex) {
          context.read<HistoryCubit>().getHistory();
        }
      },
      child: context.isMobile
          ? const Scaffold(
              body: BuildNavBarBody(),
              bottomNavigationBar: BuildNavBar(),
            )
          : const Scaffold(
              body: SafeArea(
                child: Row(
                  children: [
                    BuildNavRail(),
                    VerticalDivider(width: 1),
                    Expanded(child: BuildNavBarBody()),
                  ],
                ),
              ),
            ),
    );
  }
}
