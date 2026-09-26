import 'package:dio/dio.dart';
import 'package:efg_currency_converter/core/api/api_consumer.dart';
import 'package:efg_currency_converter/core/api/dio_consumer.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:efg_currency_converter/core/controllers/theme_controller.dart';
import 'package:efg_currency_converter/core/services/remote/generic_service/datasource/generic_crud_datasource.dart';
import 'package:efg_currency_converter/core/services/remote/generic_service/repository/generic_crud_repository.dart';
import 'package:efg_currency_converter/features/converter/converter_service_locator.dart';
import 'package:efg_currency_converter/features/history/history_service_locator.dart';
import 'package:efg_currency_converter/features/home/home_service_locator.dart';
import 'package:get_it/get_it.dart';

mixin ServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    final Dio dio = Dio();

    await HomeServiceLocator.init();
    await ConverterServiceLocator.init();
    await HistoryServiceLocator.init();

    instance
      ..registerFactory<NetworkCubit>(() => NetworkCubit()..init())
      ..registerFactory<ThemeController>(() => ThemeController()..init())
      ..registerLazySingleton<Dio>(() => dio)
      ..registerLazySingleton<DioConsumer>(
        () => ApiConsumer(dio: instance())..initialize(),
      )
      ..registerLazySingleton<GenericCrudRepository>(
        () => GenericCrudDataSource(instance()),
      );
  }
}
