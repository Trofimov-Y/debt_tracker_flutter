import 'package:debt_tracker/data/datasources/remote/authentication_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/user_mapper.dart';
import 'package:debt_tracker/data/models/user_model.dart';
import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._userMapper,
    this._logger,
  );

  final Logger _logger;
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final UserMapper _userMapper;

  @override
  Stream<UserEntity?> getAuthenticationChanges() {
    return _authenticationRemoteDataSource.getAuthenticationChanges().map(
      (model) {
        return _userMapper.tryConvert<UserModel, UserEntity>(model);
      },
    );
  }

  @override
  Future<Either<Failure, void>> singInWithGoogle({String? idToken, String? accessToken}) {
    return TaskEither.tryCatch(
      () => _authenticationRemoteDataSource.singInWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
      ),
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    ).run();
  }

  @override
  Future<Either<Failure, void>> deleteProfile() {
    final result = TaskEither.tryCatch(() {
      return _authenticationRemoteDataSource.deleteUserData();
    }, (error, stackTrace) {
      _logger.e(error.toString(), error, stackTrace);
      return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
    }).flatMap(
      (_) => TaskEither.tryCatch(
        () => _authenticationRemoteDataSource.deleteProfile(),
        (error, stackTrace) {
          _logger.e(error.toString(), error, stackTrace);
          return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
        },
      ),
    );
    return result.run();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    return TaskEither.tryCatch(
      () => _authenticationRemoteDataSource.signOut(),
      (error, stackTrace) {
        _logger.e(error.toString(), error, stackTrace);
        return GeneraFailure(error: error.toString(), stackTrace: stackTrace);
      },
    ).run();
  }
}
