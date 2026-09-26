part of '../screens/converter_screen.dart';

class BuildCurrencyPair extends StatelessWidget {
  const BuildCurrencyPair({super.key});

  List<DropDownItem<String>> _toDropDownItems(List<Currency> currencies) {
    return currencies
        .map(
          (currency) => DropDownItem(
            value: currency.code,
            title: currency.name,
            badgeText: currency.displaySymbol,
            searchText: currency.code,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
      buildWhen: (previous, current) =>
          previous.fromCode != current.fromCode ||
          previous.toCode != current.toCode ||
          previous.currencies != current.currencies ||
          previous.isOffline != current.isOffline ||
          previous.cachedRates != current.cachedRates,
      builder: (context, state) {
        final cubit = context.read<ConverterCubit>();
        final swap = state.canSwap ? cubit.swap : null;
        final from = CustomDropDown<String>(
          labelText: context.localizations.from,
          sheetTitle: context.localizations.convertFrom,
          hintText: context.localizations.selectCurrency,
          searchHintText: context.localizations.searchCurrency,
          emptySearchText: context.localizations.noCurrenciesMatch,
          items: _toDropDownItems(state.fromCurrencies),
          value: state.fromCode,
          onChanged: cubit.selectFrom,
        );
        final to = CustomDropDown<String>(
          labelText: context.localizations.to,
          sheetTitle: context.localizations.convertTo,
          hintText: context.localizations.selectCurrency,
          searchHintText: context.localizations.searchCurrency,
          emptySearchText: context.localizations.noCurrenciesMatch,
          items: _toDropDownItems(state.toCurrencies),
          value: state.toCode,
          onChanged: cubit.selectTo,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 520) {
              return Row(
                children: [
                  Expanded(child: from),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: BuildSwapButton(
                      axis: Axis.horizontal,
                      onTap: swap,
                    ),
                  ),
                  Expanded(child: to),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                from,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.xs,
                  ),
                  child: Center(child: BuildSwapButton(onTap: swap)),
                ),
                to,
              ],
            );
          },
        );
      },
    );
  }
}
