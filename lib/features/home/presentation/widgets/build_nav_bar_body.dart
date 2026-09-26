part of '../screens/nav_bar_screen.dart';

class BuildNavBarBody extends StatefulWidget {
  const BuildNavBarBody({super.key});

  @override
  State<BuildNavBarBody> createState() => BuildNavBarBodyState();
}

class BuildNavBarBodyState extends State<BuildNavBarBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: AppDurations.slow,
    value: 1,
  );
  late final Animation<double> fade = CurvedAnimation(
    parent: controller,
    curve: Curves.easeOutCubic,
  );
  late final Animation<Offset> slide = Tween<Offset>(
    begin: const Offset(0, 0.02),
    end: Offset.zero,
  ).animate(fade);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit, int>(
      listener: (context, currentIndex) => controller.forward(from: 0),
      builder: (context, currentIndex) {
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(
            position: slide,
            child: IndexedStack(
              index: currentIndex,
              children: const [
                ConverterScreen(),
                HistoryScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
