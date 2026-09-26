import 'package:dartz/dartz.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:efg_currency_converter/core/services/remote/generic_service/repository/generic_crud_repository.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/models/rate.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';

part 'end_points.dart';

class ConverterDatasource extends ConverterRepository {
  ConverterDatasource(this._client);

  final GenericCrudRepository _client;

  @override
  Future<Either<Failure, List<Currency>>> getCurrencies() async {
    return _client.get<List<Currency>>(
      apiPath: ConverterEndPoints.getCurrencies,
      dataMapper: (json) => (json as List)
          .whereType<Map<String, dynamic>>()
          .map(Currency.fromJson)
          .toList()
        ..sort((a, b) => a.code.compareTo(b.code)),
    );
  }

  @override
  Future<Either<Failure, ExchangeRates>> getRates(String base) async {
    return _client.get<ExchangeRates>(
      apiPath: ConverterEndPoints.getRates,
      queryParameters: {'base': base},
      dataMapper: (json) => ExchangeRates.fromRates(
        base: base,
        rates: (json as List)
            .whereType<Map<String, dynamic>>()
            .map(Rate.fromJson)
            .toList(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
