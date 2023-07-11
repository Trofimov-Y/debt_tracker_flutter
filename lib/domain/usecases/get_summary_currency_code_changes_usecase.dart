import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSummaryCurrencyCodeChangesUseCase {
  const GetSummaryCurrencyCodeChangesUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Stream<String> call() {
    return _profileRepository.getSummaryCurrencyCodeChanges();
  }
}
