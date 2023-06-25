import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAuthenticationChangesUseCase {
  const GetAuthenticationChangesUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  Stream<UserEntity?> call() {
    return _authenticationRepository.getAuthenticationChanges();
  }
}
