import 'package:freezed_annotation/freezed_annotation.dart';

part 'debts_summary.freezed.dart';

@Freezed(toStringOverride: true)
class DebtsSummary with _$DebtsSummary {
  const factory DebtsSummary({
    required double totalOwedToMe,
    required double totalOwedByMe,
    required String currencyCode,
  }) = _DebtsSummary;
}
