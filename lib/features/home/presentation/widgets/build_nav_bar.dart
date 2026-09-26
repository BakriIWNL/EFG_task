part of '../screens/nav_bar_screen.dart';

class BuildNavBar extends StatelessWidget {
  const BuildNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xl);
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLowest,
          borderRadius: radius,
          boxShadow: AppShadows.raised(context.appTheme.shadow),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: BlocBuilder<NavBarCubit, int>(
          builder: (context, currentIndex) {
            return NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: context.read<NavBarCubit>().setIndex,
              animationDuration: AppDurations.slow,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.currency_exchange_rounded),
                  label: context.localizations.convert,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.history_rounded),
                  label: context.localizations.history,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
