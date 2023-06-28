import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debts_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateDebtUseCase {
  const CreateDebtUseCase(this._debtsRepository);

  final DebtsRepository _debtsRepository;

  Future<Either<Failure, void>> call(DebtEntity entity) {
    return _debtsRepository.createDebt(entity);
  }
}
