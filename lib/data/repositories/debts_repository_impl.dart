import 'package:debt_tracker/data/datasources/remote/debts_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debt_mapper.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
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
    this._logger,
  );

  final Logger _logger;
  final DebtsRemoteDataSource _debtsRemoteDataSource;
  final DebtMapper _debtMapper;

  @override
  Either<Failure, Stream<List<DebtEntity>>> getDebtsChanges() {
    return Either.tryCatch(
      () => _debtsRemoteDataSource.getDebtsChanges().map(
        (models) {
          return models.map((e) => _debtMapper.convert<DebtModel, DebtEntity>(e)).toList();
        },
      ),
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    );
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
