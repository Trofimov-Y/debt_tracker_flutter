part of 'all_debts_cubit.dart';

@freezed
class AllDebtsState with _$AllDebtsState {
  const factory AllDebtsState.initial() = _Initial;

  const factory AllDebtsState.success(
    List<DebtEntity> toMeDebts,
    List<DebtEntity> owedByMeDebts,
  ) = _Success;

  const factory AllDebtsState.error(Failure failure) = _Error;
}
