import 'package:efg_currency_converter/features/history/data/datasources/local/local_history_datasource.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:get_it/get_it.dart';

mixin HistoryServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    instance
      ..registerFactory<HistoryCubit>(
        () => HistoryCubit(
          instance(),
          instance(),
          instance(),
        ),
      )
      ..registerLazySingleton<LocalHistoryRepository>(
        LocalHistoryDataSource.new,
      );
  }
}
