import 'package:debt_tracker/data/datasources/remote/authentication_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/user_mapper.dart';
import 'package:debt_tracker/data/models/user_model.dart';
import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
import 'package:debt_tracker/domain/utils/repository_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl with RepositoryMixin implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._userMapper,
  );

  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final UserMapper _userMapper;

  @override
  Stream<UserEntity?> getAuthenticationChanges() {
    return wrapStream(
      _authenticationRemoteDataSource.getAuthenticationChanges().map(
        (model) {
          return _userMapper.tryConvert<UserModel, UserEntity>(model);
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> singInWithGoogle({String? idToken, String? accessToken}) {
    final task = createTask(
      () => _authenticationRemoteDataSource.singInWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
      ),
      (_) => const FailureWhileGoogleSignIn(),
    );
    return task.run();
  }

  @override
  Future<Either<Failure, void>> deleteProfile() {
    final task = createTask(
      () => _authenticationRemoteDataSource.deleteUserData(),
      (_) => const FailureWhileDeletingUserData(),
    ).flatMap(
      (_) => createTask(
        () => _authenticationRemoteDataSource.deleteProfile(),
        (_) => const FailureWhileDeletingProfile(),
      ),
    );
    return task.run();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    final task = createTask(
      () => _authenticationRemoteDataSource.signOut(),
      (error) => const FailureWhileSignOut(),
    );
    return task.run();
  }
}
