import 'package:debt_tracker/data/datasources/remote/authentication_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/user_mapper.dart';
import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._userMapper,
  );

  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final UserMapper _userMapper;

  @override
  Stream<UserEntity?> getAuthenticationChanges() {
    return _authenticationRemoteDataSource.getAuthenticationChanges().map(
          (model) => _userMapper.fromModel(model),
        );
  }
}
