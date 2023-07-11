part of 'debts_summary_cubit.dart';

@freezed
class DebtsSummaryState with _$DebtsSummaryState {
  const factory DebtsSummaryState.initial() = _Initial;

  const factory DebtsSummaryState.success(
    DebtsSummary summary,
  ) = _Success;

  const factory DebtsSummaryState.error(Failure failure) = _Error;
}
