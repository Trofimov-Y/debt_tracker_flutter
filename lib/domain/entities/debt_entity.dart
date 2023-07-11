import 'package:freezed_annotation/freezed_annotation.dart';

part 'debt_entity.freezed.dart';

enum DebtType { toMe, byMe }

@Freezed(toStringOverride: true)
class DebtEntity with _$DebtEntity {
  const factory DebtEntity({
    required String? id,
    required String name,
    required String description,
    required double amount,
    required String currencyCode,
    required DateTime incurredDate,
    required DateTime? dueDate,
    required DebtType type,
  }) = _DebtEntity;
}
