part of 'debts_feed_cubit.dart';

@freezed
class DebtsFeedState with _$DebtsFeedState {
  const factory DebtsFeedState.initial() = _Initial;

  const factory DebtsFeedState.success(List<FeedAction> actions) = _Success;

  const factory DebtsFeedState.error(Failure failure) = _Error;
}
