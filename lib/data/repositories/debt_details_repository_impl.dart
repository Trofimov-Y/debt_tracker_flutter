import 'package:debt_tracker/data/datasources/remote/debt_details_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debt_mapper.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debt_details_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: DebtDetailsRepository)
class DebtDetailsRepositoryImpl implements DebtDetailsRepository {
  const DebtDetailsRepositoryImpl(
    this._debtMapper,
    this._logger,
    this._debtDetailsRemoteDataSource,
  );

  final Logger _logger;
  final DebtMapper _debtMapper;
  final DebtDetailsRemoteDataSource _debtDetailsRemoteDataSource;

  @override
  Stream<DebtEntity> getDebtChanges(String id) {
    return _debtDetailsRemoteDataSource.getDebtChanges(id).map(
      (model) {
        return _debtMapper.convert<DebtModel, DebtEntity>(model);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteDebt(String id) {
    final task = TaskEither.tryCatch(
      () => _debtDetailsRemoteDataSource.deleteDebt(id),
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    );
    return task.run();
  }

  @override
  Future<Either<Failure, void>> editDebt(DebtEntity debt) {
    final task = TaskEither.tryCatch(
      () => _debtDetailsRemoteDataSource.editDebt(
        _debtMapper.convert<DebtEntity, DebtModel>(debt),
      ),
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    );
    return task.run();
  }
}
