import 'package:debt_tracker/domain/entities/user_entity.dart';

abstract interface class AuthenticationRepository {
  Stream<UserEntity?> getAuthenticationChanges();
}
