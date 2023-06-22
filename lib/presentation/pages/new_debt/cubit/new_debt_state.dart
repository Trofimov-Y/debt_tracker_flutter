part of 'new_debt_cubit.dart';

@freezed
class NewDebtState with _$NewDebtState {
  const factory NewDebtState.data({
    required DateTime incurredDate,
    required DebtType type,
    DateTime? dueDate,
  }) = _Data;
}
