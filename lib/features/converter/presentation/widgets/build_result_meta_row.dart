part of '../screens/converter_screen.dart';

class BuildResultMetaRow extends StatelessWidget {
  const BuildResultMetaRow({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.isBold = false,
  });

  final IconData icon;
  final String text;
  final Color color;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: context.appTextStyles.bodyMedium.tabular.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.w700 : null,
            ),
          ),
        ),
      ],
    );
  }
}
