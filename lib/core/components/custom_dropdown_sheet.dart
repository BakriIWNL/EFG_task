import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/custom_badge.dart';
import 'package:efg_currency_converter/core/components/custom_dropdown.dart';
import 'package:efg_currency_converter/core/components/custom_empty_component.dart';
import 'package:efg_currency_converter/core/components/custom_list_tile.dart';
import 'package:efg_currency_converter/core/components/custom_textfield.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDropDownSheet<T> extends StatefulWidget {
  const CustomDropDownSheet({
    super.key,
    required this.title,
    required this.items,
    required this.searchHintText,
    required this.emptySearchText,
    this.value,
    this.isSearchEnabled = true,
  });

  final String title;
  final List<DropDownItem<T>> items;
  final String searchHintText;
  final String Function(String query) emptySearchText;
  final T? value;
  final bool isSearchEnabled;

  @override
  State<CustomDropDownSheet<T>> createState() => CustomDropDownSheetState<T>();
}

class CustomDropDownSheetState<T> extends State<CustomDropDownSheet<T>> {
  String query = '';

  List<DropDownItem<T>> get filteredItems {
    final search = query.trim().toLowerCase();
    if (search.isEmpty) {
      return widget.items;
    }
    return widget.items
        .where(
          (item) =>
              item.title.toLowerCase().contains(search) ||
              item.searchText.toLowerCase().contains(search),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredItems;
    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQuery.viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xxl,
              AppSpacing.lg,
              AppSpacing.xxl,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: context.appTextStyles.titleLarge),
                if (widget.isSearchEnabled) ...[
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    hintText: widget.searchHintText,
                    prefixIcon: Icons.search,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => setState(() => query = value),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? CustomEmptyComponent(
                    icon: Icons.search_off,
                    message: widget.emptySearchText(query),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      0,
                      AppSpacing.sm,
                      AppSpacing.lg,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = item.value == widget.value;
                      return CustomListTile(
                        isSelected: isSelected,
                        leading: CustomBadge(text: item.badgeText),
                        title: Text(item.title),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: context.colorScheme.primary,
                              )
                            : null,
                        onTap: () => context.pop(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
