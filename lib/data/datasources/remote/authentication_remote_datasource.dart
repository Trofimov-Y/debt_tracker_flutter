import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthenticationRemoteDataSource {
  Stream<User?> getAuthenticationChanges();
}

@Injectable(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  AuthenticationRemoteDataSourceImpl(this.firebaseAuthInstance);

  final FirebaseAuth firebaseAuthInstance;

  @override
  Stream<User?> getAuthenticationChanges() {
    return firebaseAuthInstance.authStateChanges();
  }
}
