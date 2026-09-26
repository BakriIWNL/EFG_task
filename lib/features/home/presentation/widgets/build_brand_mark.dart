part of '../screens/nav_bar_screen.dart';

class BuildBrandMark extends StatelessWidget {
  const BuildBrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.appTheme.jungle, context.appTheme.forest],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.glow(context.appTheme.emerald),
      ),
      child: Icon(
        Icons.currency_exchange_rounded,
        color: context.appTheme.white,
      ),
    );
  }
}
