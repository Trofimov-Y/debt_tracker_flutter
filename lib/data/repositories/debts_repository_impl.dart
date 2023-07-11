import 'package:debt_tracker/data/datasources/remote/debts_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debt_mapper.dart';
import 'package:debt_tracker/data/mappers/feed_action_mapper.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/data/models/feed_action_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debts_repository.dart';
import 'package:debt_tracker/domain/utils/repository_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DebtsRepository)
class DebtsRepositoryImpl with RepositoryMixin implements DebtsRepository {
  const DebtsRepositoryImpl(
    this._debtsRemoteDataSource,
    this._debtMapper,
    this._debtFeedActionMapper,
  );

  final DebtsRemoteDataSource _debtsRemoteDataSource;
  final DebtMapper _debtMapper;
  final FeedActionMapper _debtFeedActionMapper;

  @override
  Stream<List<DebtEntity>> getDebtsChanges() {
    return wrapStream(
      _debtsRemoteDataSource.getDebtsChanges().map((models) {
        return models.map((model) => _debtMapper.convert<DebtModel, DebtEntity>(model)).toList();
      }),
    );
  }

  @override
  Stream<List<FeedAction>> getDebtsFeedChanges() {
    return wrapStream(
      _debtsRemoteDataSource.getDebtsFeedChanges().map((models) {
        return models.map((model) {
          return _debtFeedActionMapper.convert<FeedActionModel, FeedAction>(model);
        }).toList();
      }),
    );
  }

  @override
  Future<Either<Failure, void>> createDebt(DebtEntity entity) {
    final task = createTask(
      () => _debtsRemoteDataSource.createDebt(
        _debtMapper.convert<DebtEntity, DebtModel>(entity),
      ),
      (_) => const FailureWhileCreatingDebt(),
    );
    return task.run();
  }
}
