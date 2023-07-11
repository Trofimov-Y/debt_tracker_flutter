import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DebtDetailsRepository {
  Stream<DebtEntity> getDebtChanges(String id);

  Future<Either<Failure, void>> editDebt(DebtEntity debt);

  Future<Either<Failure, void>> deleteDebt(String id);
}
