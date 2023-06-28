part of 'new_debt_cubit.dart';

@freezed
class NewDebtState with _$NewDebtState {
  const factory NewDebtState.data({
    required DebtType type,
    required DateTime incurredDate,
    DateTime? dueDate,
  }) = _Data;

  const factory NewDebtState.loading({
    required DebtType type,
    required DateTime incurredDate,
    DateTime? dueDate,
  }) = _Loading;

  const factory NewDebtState.error({
    required DebtType type,
    required DateTime incurredDate,
    DateTime? dueDate,
    required Failure failure,
  }) = _Error;
}
