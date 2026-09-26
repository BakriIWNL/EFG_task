import 'package:dartz/dartz.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';

abstract class ConverterRepository {
  Future<Either<Failure, List<Currency>>> getCurrencies();

  Future<Either<Failure, ExchangeRates>> getRates(String base);
}
