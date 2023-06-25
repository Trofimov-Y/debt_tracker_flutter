import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthenticationRemoteDataSource {
  Stream<UserModel?> getAuthenticationChanges();

  Future<void> singInAnonymously();

  Future<void> singInWithGoogle({String? idToken, String? accessToken});
}

@Injectable(as: AuthenticationRemoteDataSource)
final class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(
    this._firebaseAuthInstance,
    this._firestore,
  );

  final FirebaseAuth _firebaseAuthInstance;
  final FirebaseFirestore _firestore;

  String getAuthenticationUid() {
    return _firebaseAuthInstance.currentUser!.uid;
  }

  @override
  Stream<UserModel?> getAuthenticationChanges() {
    return _firebaseAuthInstance.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        email: user.email,
        name: user.displayName,
        isAnonymous: user.isAnonymous,
      );
    });
  }

  @override
  Future<void> singInAnonymously() async {
    final firebaseUserCredential = await _firebaseAuthInstance.signInAnonymously();

    _createUserFromCredential(firebaseUserCredential);
  }

  @override
  Future<void> singInWithGoogle({String? idToken, String? accessToken}) async {
    final googleCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential = await _firebaseAuthInstance.signInWithCredential(googleCredential);

    await _createUserFromCredential(userCredential);
  }

  Future<void> _createUserFromCredential(UserCredential userCredential) async {
    final reference = await _firestore.collection('users').doc(userCredential.user!.uid).get();

    if (reference.exists) return;

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': userCredential.user!.displayName,
      'email': userCredential.user!.email,
      'isAnonymous': userCredential.user!.isAnonymous,
    });
  }
}
