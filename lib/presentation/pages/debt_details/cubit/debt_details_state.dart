part of 'debt_details_cubit.dart';

@freezed
class DebtDetailsState with _$DebtDetailsState {
  const factory DebtDetailsState.initial() = _Initial;

  const factory DebtDetailsState.success(DebtEntity debt) = _Success;

  const factory DebtDetailsState.error(Failure failure) = _Error;
}
