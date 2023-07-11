import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSummaryStatusChangesUseCase {
  const GetSummaryStatusChangesUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Stream<bool> call() {
    return _profileRepository.getSummaryStatusChanges();
  }
}
