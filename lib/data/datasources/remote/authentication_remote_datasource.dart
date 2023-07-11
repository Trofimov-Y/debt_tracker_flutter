import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract interface class AuthenticationRemoteDataSource {
  Stream<UserModel?> getAuthenticationChanges();

  Future<void> signOut();

  Future<void> deleteUserData();

  Future<void> deleteProfile();

  Future<void> singInWithGoogle({String? idToken, String? accessToken});
}

@Injectable(as: AuthenticationRemoteDataSource)
final class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(
    this._auth,
    this._firestore,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<UserModel?> getAuthenticationChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        email: user.email!,
        name: user.displayName!,
      );
    });
  }

  @override
  Future<void> singInWithGoogle({String? idToken, String? accessToken}) async {
    final googleCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential = await _auth.signInWithCredential(googleCredential);

    await _createUserFromCredential(userCredential);
  }

  Future<void> _createUserFromCredential(UserCredential userCredential) async {
    final reference = await _firestore.collection('users').doc(userCredential.user!.uid).get();

    if (reference.exists) return;

    final format = NumberFormat.simpleCurrency(locale: Platform.localeName);

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': userCredential.user!.displayName,
      'email': userCredential.user!.email,

      'summaryEnabled': true,
      // TODO Maybe find a better way to get the currency name
      'summaryCurrencyCode': format.currencyName ?? 'USD',
    });
  }

  @override
  Future<void> deleteUserData() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).delete();
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> deleteProfile() => _auth.currentUser!.delete();
}
