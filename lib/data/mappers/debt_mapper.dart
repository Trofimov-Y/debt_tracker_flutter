// ignore_for_file: avoid_classes_with_only_static_members

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:injectable/injectable.dart';

part 'debt_mapper.g.dart';

@injectable
@AutoMappr(
  [
    MapType<DebtEntity, DebtModel>(
      fields: [Field('type', custom: DebtMapper.mapTypeFromEntity)],
    ),
    MapType<DebtModel, DebtEntity>(
      fields: [Field('type', custom: DebtMapper.mapTypeFromModel)],
    ),
  ],
)
class DebtMapper extends $DebtMapper {
  static String mapTypeFromEntity(DebtEntity entity) => entity.type.name;

  static DebtType mapTypeFromModel(DebtModel model) {
    return switch (model.type) {
      'toMe' => DebtType.toMe,
      'byMe' => DebtType.byMe,
      _ => throw Exception('Unknown type: ${model.type}'),
    };
  }
}
