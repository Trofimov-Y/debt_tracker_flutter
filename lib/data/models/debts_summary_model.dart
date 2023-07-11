import 'package:freezed_annotation/freezed_annotation.dart';

part 'debts_summary_model.g.dart';

@JsonSerializable(createToJson: false)
class DebtsSummaryModel {
  const DebtsSummaryModel({
    required this.totalOwedToMe,
    required this.totalOwedByMe,
    required this.currencyCode,
  });

  factory DebtsSummaryModel.fromJson(Map<String, dynamic> json) {
    return _$DebtsSummaryModelFromJson(json);
  }

  final double totalOwedToMe;
  final double totalOwedByMe;
  final String currencyCode;
}
