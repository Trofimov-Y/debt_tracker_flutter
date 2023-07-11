import 'package:debt_tracker/data/datasources/remote/debts_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debt_mapper.dart';
import 'package:debt_tracker/data/mappers/feed_action_mapper.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/data/models/feed_action_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debts_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: DebtsRepository)
class DebtsRepositoryImpl implements DebtsRepository {
  const DebtsRepositoryImpl(
    this._debtsRemoteDataSource,
    this._debtMapper,
    this._debtFeedActionMapper,
    this._logger,
  );

  final Logger _logger;
  final DebtsRemoteDataSource _debtsRemoteDataSource;
  final DebtMapper _debtMapper;
  final FeedActionMapper _debtFeedActionMapper;

  @override
  Stream<List<DebtEntity>> getDebtsChanges() {
    return _debtsRemoteDataSource.getDebtsChanges().map((models) {
      return models.map((e) => _debtMapper.convert<DebtModel, DebtEntity>(e)).toList();
    });
  }

  @override
  Stream<List<FeedAction>> getDebtsFeedChanges() {
    return _debtsRemoteDataSource.getDebtsFeedChanges().map((models) {
      return models.map((e) {
        return _debtFeedActionMapper.convert<FeedActionModel, FeedAction>(e);
      }).toList();
    }).handleError((error) {
      _logger.w(error.toString(), error);
    });
  }

  @override
  Future<Either<Failure, void>> createDebt(DebtEntity entity) {
    return TaskEither.tryCatch(
      () => _debtsRemoteDataSource.createDebt(
        _debtMapper.convert<DebtEntity, DebtModel>(entity),
      ),
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    ).run();
  }
}
