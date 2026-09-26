import 'package:animate_do/animate_do.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/index.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:efg_currency_converter/core/utils/validations/input_formatters.dart';
import 'package:efg_currency_converter/core/utils/validations/model/amount_validations.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/presentation/controllers/converter_cubit.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/shared/widgets/convert_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../widgets/build_amount_field.dart';
part '../widgets/build_conversion_error_card.dart';
part '../widgets/build_conversion_result.dart';
part '../widgets/build_converter_body.dart';
part '../widgets/build_converter_form.dart';
part '../widgets/build_converter_loading_widget.dart';
part '../widgets/build_currency_pair.dart';
part '../widgets/build_rates_date.dart';
part '../widgets/build_result_card.dart';
part '../widgets/build_result_meta_row.dart';
part '../widgets/build_result_placeholder.dart';
part '../widgets/build_swap_button.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.convert),
        actions: const [CustomThemeButton()],
      ),
      body: const BuildConverterBody(),
    );
  }
}
