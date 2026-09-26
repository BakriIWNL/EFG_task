part of '../screens/nav_bar_screen.dart';

class BuildNavRail extends StatelessWidget {
  const BuildNavRail({super.key});

  @override
  Widget build(BuildContext context) {
    final isExtended = context.isDesktop;
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, currentIndex) {
        return NavigationRail(
          selectedIndex: currentIndex,
          onDestinationSelected: context.read<NavBarCubit>().setIndex,
          extended: isExtended,
          labelType: isExtended
              ? NavigationRailLabelType.none
              : NavigationRailLabelType.all,
          leading: const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: BuildBrandMark(),
          ),
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.currency_exchange_rounded),
              label: Text(context.localizations.convert),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.history_rounded),
              label: Text(context.localizations.history),
            ),
          ],
        );
      },
    );
  }
}
