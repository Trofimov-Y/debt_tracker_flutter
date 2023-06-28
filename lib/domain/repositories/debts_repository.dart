import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DebtsRepository {
  Either<Failure, Stream<List<DebtEntity>>> getDebtsChanges();

  Future<Either<Failure, void>> createDebt(DebtEntity entity);
}
