import 'package:animate_do/animate_do.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/components/index.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:efg_currency_converter/shared/widgets/convert_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../widgets/build_clear_history_button.dart';
part '../widgets/build_delete_background.dart';
part '../widgets/build_history_body.dart';
part '../widgets/build_history_list.dart';
part '../widgets/build_history_loading_widget.dart';
part '../widgets/build_history_tile.dart';
part '../widgets/build_pair_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.history),
        actions: const [
          BuildClearHistoryButton(),
          CustomThemeButton(),
        ],
      ),
      body: const BuildHistoryBody(),
    );
  }
}
