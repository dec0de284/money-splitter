class AllocationResult {
  const AllocationResult({
    required this.amounts,
    required this.remainingAmount,
    required this.remainingPercentage,
  });

  final List<int> amounts;
  final int remainingAmount;
  final int remainingPercentage;
}

class AllocationCalculator {
  const AllocationCalculator._();

  static int maximumFor(List<int> percentages, int rowIndex) {
    _validatePercentages(percentages);
    if (rowIndex < 0 || rowIndex >= percentages.length) {
      throw RangeError.index(rowIndex, percentages, 'rowIndex');
    }

    final usedByOtherRows = percentages.indexed
        .where((entry) => entry.$1 != rowIndex)
        .fold<int>(0, (sum, entry) => sum + entry.$2);
    return 100 - usedByOtherRows;
  }

  static AllocationResult calculate({
    required int capitalMinorUnits,
    required List<int> percentages,
  }) {
    if (capitalMinorUnits < 0) {
      throw ArgumentError.value(
        capitalMinorUnits,
        'capitalMinorUnits',
        'Must not be negative.',
      );
    }
    _validatePercentages(percentages);

    final allocatedPercentage = percentages.fold<int>(0, (a, b) => a + b);
    if (allocatedPercentage > 100) {
      throw ArgumentError.value(
        percentages,
        'percentages',
        'The total percentage must not exceed 100.',
      );
    }

    final weights = [...percentages, 100 - allocatedPercentage];
    final baseAmounts = <int>[];
    final remainders = <({int index, int remainder})>[];

    for (final (index, weight) in weights.indexed) {
      final weightedCapital = capitalMinorUnits * weight;
      baseAmounts.add(weightedCapital ~/ 100);
      remainders.add((index: index, remainder: weightedCapital % 100));
    }

    var undistributed =
        capitalMinorUnits - baseAmounts.fold<int>(0, (a, b) => a + b);
    remainders.sort((a, b) {
      final remainderComparison = b.remainder.compareTo(a.remainder);
      return remainderComparison != 0
          ? remainderComparison
          : a.index.compareTo(b.index);
    });

    for (var index = 0; index < undistributed; index++) {
      baseAmounts[remainders[index].index]++;
    }

    return AllocationResult(
      amounts: List.unmodifiable(baseAmounts.take(percentages.length)),
      remainingAmount: baseAmounts.last,
      remainingPercentage: 100 - allocatedPercentage,
    );
  }

  static void _validatePercentages(List<int> percentages) {
    for (final percentage in percentages) {
      if (percentage < 0 || percentage > 100) {
        throw ArgumentError.value(
          percentage,
          'percentages',
          'Each percentage must be between 0 and 100.',
        );
      }
    }
  }
}
