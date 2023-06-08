import 'package:debt_tracker/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthenticationRemoteDataSource {
  Stream<UserModel?> getAuthenticationChanges();
}

@Injectable(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  AuthenticationRemoteDataSourceImpl(this.firebaseAuthInstance);

  final FirebaseAuth firebaseAuthInstance;

  @override
  Stream<UserModel?> getAuthenticationChanges() {
    return firebaseAuthInstance.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        email: user.email,
        name: user.displayName,
        isAnonymous: user.isAnonymous,
      );
    });
  }
}
