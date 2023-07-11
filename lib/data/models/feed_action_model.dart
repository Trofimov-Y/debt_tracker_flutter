import 'package:json_annotation/json_annotation.dart';

part 'feed_action_model.g.dart';

@JsonSerializable()
class FeedActionModel {
  const FeedActionModel({
    required this.debtId,
    required this.type,
    required this.createdAt,
    required this.debtName,
    required this.amount,
    required this.currencyCode,
  });

  factory FeedActionModel.fromJson(Map<String, dynamic> json) => _$FeedActionModelFromJson(json);

  final String debtId;
  final String type;
  final DateTime createdAt;
  final double? amount;
  final String? currencyCode;
  final String debtName;

  Map<String, dynamic> toJson() => _$FeedActionModelToJson(this);
}
