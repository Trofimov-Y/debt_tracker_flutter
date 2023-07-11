import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/debt_details_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteDebtUseCase {
  const DeleteDebtUseCase(this._debtDetailsRepository);

  final DebtDetailsRepository _debtDetailsRepository;

  Future<Either<Failure, void>> call(String id) {
    return _debtDetailsRepository.deleteDebt(id);
  }
}
