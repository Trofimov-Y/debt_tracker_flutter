import 'package:freezed_annotation/freezed_annotation.dart';

part 'debt_feed_action.freezed.dart';

@Freezed(toStringOverride: true)
class FeedAction with _$FeedAction {
  const factory FeedAction({
    required String debtId,
    required ActionType type,
    required DateTime createdAt,
    required String debtName,
    required double? amount,
    required String? currencyCode,
  }) = _FeedAction;
}

enum ActionType {
  create,
  delete,
  partialRepayment,
  fullRepayment,
  partialAdditionDebt,
}
