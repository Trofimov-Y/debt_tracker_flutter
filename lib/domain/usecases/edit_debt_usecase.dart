import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debt_details_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditDebtUseCase {
  const EditDebtUseCase(this._debtDetailsRepository);

  final DebtDetailsRepository _debtDetailsRepository;

  Future<Either<Failure, void>> call(DebtEntity debtEntity) {
    return _debtDetailsRepository.editDebt(debtEntity);
  }
}
