import 'package:efg_currency_converter/features/history/data/datasources/local/local_history_datasource.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LocalHistoryDataSource dataSource;

  Conversion buildConversion(String id, DateTime createdAt) {
    return Conversion(
      id: id,
      amount: 10,
      fromCode: 'USD',
      toCode: 'EUR',
      fromSymbol: r'$',
      toSymbol: '€',
      rate: 0.5,
      convertedAmount: 5,
      rateDate: DateTime(2026, 9, 26),
      updatedAt: DateTime(2026, 9, 26, 12),
      createdAt: createdAt,
    );
  }

  final tOlder = buildConversion('1', DateTime(2026, 9, 25));
  final tNewer = buildConversion('2', DateTime(2026, 9, 26));

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    dataSource = LocalHistoryDataSource();
  });

  group('LocalHistoryDataSource', () {
    test('returns the conversions newest first', () async {
      await dataSource.saveConversion(tOlder);
      await dataSource.saveConversion(tNewer);

      expect(await dataSource.getConversions(), [tNewer, tOlder]);
    });

    test('replaces a conversion saved with the same id', () async {
      await dataSource.saveConversion(tOlder);
      final recalculated = tOlder.copyWith(rate: 0.6, isOutdated: true);

      final isSaved = await dataSource.saveConversion(recalculated);

      expect(isSaved, isTrue);
      expect(await dataSource.getConversions(), [recalculated]);
    });

    test('deletes a single conversion', () async {
      await dataSource.saveConversion(tOlder);
      await dataSource.saveConversion(tNewer);

      await dataSource.deleteConversion('1');

      expect(await dataSource.getConversions(), [tNewer]);
    });

    test('clears every conversion', () async {
      await dataSource.saveConversion(tOlder);

      await dataSource.clearConversions();

      expect(await dataSource.getConversions(), isEmpty);
    });
  });
}
