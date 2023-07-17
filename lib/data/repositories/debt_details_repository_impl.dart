import 'package:debt_tracker/data/datasources/remote/debt_details_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debt_mapper.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debt_details_repository.dart';
import 'package:debt_tracker/domain/utils/repository_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DebtDetailsRepository)
class DebtDetailsRepositoryImpl with RepositoryMixin implements DebtDetailsRepository {
  const DebtDetailsRepositoryImpl(
    this._debtMapper,
    this._debtDetailsRemoteDataSource,
  );

  final DebtMapper _debtMapper;
  final DebtDetailsRemoteDataSource _debtDetailsRemoteDataSource;

  @override
  Stream<DebtEntity> getDebtChanges(String id) {
    return wrapStream(
      _debtDetailsRemoteDataSource.getDebtChanges(id).map(
        (model) {
          return _debtMapper.convert<DebtModel, DebtEntity>(model);
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteDebt(String id) {
    final task = createTask(
      () => _debtDetailsRemoteDataSource.deleteDebt(id),
      (_) => const Failure.deleteDebt(),
    );
    return task.run();
  }

  @override
  Future<Either<Failure, void>> editDebt(DebtEntity entity) {
    final task = createTask(
      () => _debtDetailsRemoteDataSource.editDebt(
        _debtMapper.convert<DebtEntity, DebtModel>(entity),
      ),
      (_) => const Failure.editDebt(),
    );
    return task.run();
  }
}
