import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/repositories/debt_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDebtChangesUseCase {
  const GetDebtChangesUseCase(this._debtDetailsRepository);

  final DebtDetailsRepository _debtDetailsRepository;

  Stream<DebtEntity> call(String id) => _debtDetailsRepository.getDebtChanges(id);
}
