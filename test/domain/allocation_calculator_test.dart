import 'package:flutter_test/flutter_test.dart';
import 'package:money_splitter/domain/allocation_calculator.dart';

void main() {
  group('AllocationCalculator.calculate', () {
    test('allocates 50 percent of PHP 7,000', () {
      final result = AllocationCalculator.calculate(
        capitalMinorUnits: 700000,
        percentages: [50],
      );

      expect(result.amounts, [350000]);
      expect(result.remainingAmount, 350000);
      expect(result.remainingPercentage, 50);
    });

    test('keeps allocations and remainder equal to the capital', () {
      final result = AllocationCalculator.calculate(
        capitalMinorUnits: 100,
        percentages: [33, 33, 33],
      );

      expect(result.amounts, [33, 33, 33]);
      expect(result.remainingAmount, 1);
      expect(
        result.amounts.fold<int>(0, (a, b) => a + b) + result.remainingAmount,
        100,
      );
    });

    test('distributes fractional centavos deterministically', () {
      final result = AllocationCalculator.calculate(
        capitalMinorUnits: 1,
        percentages: [50, 50],
      );

      expect(result.amounts, [1, 0]);
      expect(result.remainingAmount, 0);
    });

    test('rejects totals above 100 percent', () {
      expect(
        () => AllocationCalculator.calculate(
          capitalMinorUnits: 10000,
          percentages: [60, 41],
        ),
        throwsArgumentError,
      );
    });
  });

  group('AllocationCalculator.maximumFor', () {
    test('uses the percentage left by other rows', () {
      expect(AllocationCalculator.maximumFor([50, 0], 1), 50);
      expect(AllocationCalculator.maximumFor([10, 0], 1), 90);
    });

    test('releases capacity when a row is removed', () {
      expect(AllocationCalculator.maximumFor([60, 20, 0], 2), 20);
      expect(AllocationCalculator.maximumFor([20, 0], 1), 80);
    });
  });
}
