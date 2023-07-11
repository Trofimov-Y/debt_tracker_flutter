import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:debt_tracker/data/models/debts_summary_model.dart';
import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:injectable/injectable.dart';

part 'debts_summary_mapper.g.dart';

@Injectable()
@AutoMappr([
  MapType<DebtsSummaryModel, DebtsSummary>(),
])
class DebtsSummaryMapper extends $DebtsSummaryMapper {}
