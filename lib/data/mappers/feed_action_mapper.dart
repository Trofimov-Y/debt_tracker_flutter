// ignore_for_file: avoid_classes_with_only_static_members

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:debt_tracker/data/models/feed_action_model.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:injectable/injectable.dart';

part 'feed_action_mapper.g.dart';

@Injectable()
@AutoMappr([
  MapType<FeedActionModel, FeedAction>(
    fields: [Field('type', custom: FeedActionMapper.mapTypeFromModel)],
  ),
])
class FeedActionMapper extends $FeedActionMapper {
  static ActionType mapTypeFromModel(FeedActionModel model) {
    return switch (model.type) {
      'create' => ActionType.create,
      'delete' => ActionType.delete,
      'partialRepayment' => ActionType.partialRepayment,
      'fullRepayment' => ActionType.fullRepayment,
      'partialAdditionDebt' => ActionType.partialAdditionDebt,
      _ => throw Exception('Unknown type: ${model.type}'),
    };
  }
}
