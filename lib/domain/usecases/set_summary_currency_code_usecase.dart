import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetSummaryCurrencyCodeUseCase {
  const SetSummaryCurrencyCodeUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  Future<Either<Failure, void>> call(String currencyCode) {
    return _profileRepository.setSummaryCurrencyCode(currencyCode);
  }
}
