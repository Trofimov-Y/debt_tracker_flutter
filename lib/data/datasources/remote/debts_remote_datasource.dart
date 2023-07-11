import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/data/models/feed_action_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class DebtsRemoteDataSource {
  Stream<List<DebtModel>> getDebtsChanges();

  Stream<List<FeedActionModel>> getDebtsFeedChanges();

  Future<void> createDebt(DebtModel model);
}

@Injectable(as: DebtsRemoteDataSource)
final class DebtsRemoteDataSourceImpl implements DebtsRemoteDataSource {
  const DebtsRemoteDataSourceImpl(
    this._auth,
    this._firestore,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<void> createDebt(DebtModel model) async {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    final debtsReference = userReference.collection('debts').doc();
    _firestore.batch()
      ..set(debtsReference, model.toJson()..addAll({'id': debtsReference.id}))
      ..set(
        userReference.collection('feed').doc(),
        FeedActionModel(
          type: 'create',
          debtId: debtsReference.id,
          amount: model.amount,
          currencyCode: model.currencyCode,
          debtName: model.name,
          createdAt: DateTime.now(),
        ).toJson(),
      )
      ..commit();
  }

  @override
  Stream<List<DebtModel>> getDebtsChanges() {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('debts').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => DebtModel.fromJson(doc.data())).toList();
      },
    );
  }

  @override
  Stream<List<FeedActionModel>> getDebtsFeedChanges() {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('feed').orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => FeedActionModel.fromJson(doc.data())).toList();
      },
    );
  }
}
