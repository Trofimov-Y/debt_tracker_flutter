import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetSummaryStatusUseCase {
  const SetSummaryStatusUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Future<Either<Failure, void>> call(bool status) {
    return _profileRepository.setSummaryStatus(status);
  }
}
