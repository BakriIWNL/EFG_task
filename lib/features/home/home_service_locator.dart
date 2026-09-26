import 'package:efg_currency_converter/features/home/presentation/controllers/nav_bar_cubit.dart';
import 'package:get_it/get_it.dart';

mixin HomeServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    instance.registerFactory<NavBarCubit>(NavBarCubit.new);
  }
}
