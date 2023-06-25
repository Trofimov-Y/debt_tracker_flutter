import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInAnonymouslyUseCase {
  const SignInAnonymouslyUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  Future<Either<Failure, void>> call() {
    return _authenticationRepository.signInAnonymously();
  }
}
