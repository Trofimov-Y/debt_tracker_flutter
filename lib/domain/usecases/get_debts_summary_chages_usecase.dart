import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDebtsSummaryChangesUseCase {
  const GetDebtsSummaryChangesUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Stream<DebtsSummary> call() {
    return _profileRepository.getDebtsSummaryChanges();
  }
}
