import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/custom_badge.dart';
import 'package:efg_currency_converter/core/components/custom_dropdown_sheet.dart';
import 'package:efg_currency_converter/core/components/custom_section_label.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class DropDownItem<T> {
  DropDownItem({
    required this.value,
    required this.title,
    required this.badgeText,
    this.searchText = '',
  });

  final T value;
  final String title;
  final String badgeText;
  final String searchText;
}

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.labelText,
    required this.sheetTitle,
    required this.hintText,
    required this.searchHintText,
    required this.emptySearchText,
    required this.items,
    required this.onChanged,
    this.value,
    this.isSearchEnabled = true,
  });

  final String labelText;
  final String sheetTitle;
  final String hintText;
  final String searchHintText;
  final String Function(String query) emptySearchText;
  final List<DropDownItem<T>> items;
  final ValueChanged<T> onChanged;
  final T? value;
  final bool isSearchEnabled;

  DropDownItem<T>? get selectedItem {
    for (final item in items) {
      if (item.value == value) {
        return item;
      }
    }
    return null;
  }

  Future<void> _onOpenSheet(BuildContext context) async {
    final sheet = CustomDropDownSheet<T>(
      title: sheetTitle,
      items: items,
      value: value,
      searchHintText: searchHintText,
      emptySearchText: emptySearchText,
      isSearchEnabled: isSearchEnabled,
    );
    final DropDownItem<T>? picked;
    if (context.isMobile) {
      picked = await showModalBottomSheet<DropDownItem<T>>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.88,
          child: sheet,
        ),
      );
    } else {
      picked = await showDialog<DropDownItem<T>>(
        context: context,
        builder: (_) => Dialog(
          clipBehavior: Clip.antiAlias,
          insetAnimationCurve: Curves.easeOutCubic,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480, maxHeight: 640),
            child: sheet,
          ),
        ),
      );
    }
    if (picked != null) {
      onChanged(picked.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = selectedItem;
    return Semantics(
      button: true,
      label: '$labelText: ${selected?.title ?? hintText}',
      excludeSemantics: true,
      child: Material(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: items.isEmpty ? null : () => _onOpenSheet(context),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                CustomBadge(
                  text: selected?.badgeText ?? '---',
                  isEmphasized: true,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSectionLabel(text: labelText),
                      const SizedBox(height: AppSpacing.xs),
                      AnimatedSwitcher(
                        duration: AppDurations.medium,
                        layoutBuilder: (currentChild, previousChildren) =>
                            Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        ),
                        child: Text(
                          selected?.title ?? hintText,
                          key: ValueKey(selected?.title ?? hintText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.appTextStyles.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
