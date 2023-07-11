import 'package:json_annotation/json_annotation.dart';

part 'debt_model.g.dart';

@JsonSerializable()
class DebtModel {
  const DebtModel({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.incurredDate,
    required this.type,
    required this.currencyCode,
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);

  final String? id;
  final String name;
  final String description;
  final double amount;
  final DateTime? dueDate;
  final DateTime incurredDate;
  final String type;
  final String currencyCode;

  Map<String, dynamic> toJson() => _$DebtModelToJson(this);
}
