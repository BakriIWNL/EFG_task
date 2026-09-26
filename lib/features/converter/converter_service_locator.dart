import 'package:efg_currency_converter/features/converter/data/datasources/local/local_converter_datasource.dart';
import 'package:efg_currency_converter/features/converter/data/datasources/remote/converter_datasource.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/converter/presentation/controllers/converter_cubit.dart';
import 'package:get_it/get_it.dart';

mixin ConverterServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    instance
      ..registerFactory<ConverterCubit>(
        () => ConverterCubit(
          instance(),
          instance(),
          instance(),
        ),
      )
      ..registerLazySingleton<ConverterRepository>(
        () => ConverterDatasource(instance()),
      )
      ..registerLazySingleton<LocalConverterRepository>(
        LocalConverterDataSource.new,
      );
  }
}
