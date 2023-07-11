import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/data/models/feed_action_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class DebtDetailsRemoteDataSource {
  Stream<DebtModel> getDebtChanges(String id);

  Stream<List<FeedActionModel>> getDebtsFeedChanges();

  Future<void> editDebt(DebtModel model);

  Future<void> deleteDebt(String id);
}

@Injectable(as: DebtDetailsRemoteDataSource)
final class DebtDetailsRemoteDataSourceImpl implements DebtDetailsRemoteDataSource {
  const DebtDetailsRemoteDataSourceImpl(
    this._auth,
    this._firestore,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<List<FeedActionModel>> getDebtsFeedChanges() {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('feed').orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => FeedActionModel.fromJson(doc.data())).toList();
      },
    );
  }

  @override
  Future<void> deleteDebt(String id) {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('debts').doc(id).delete();
  }

  @override
  Future<void> editDebt(DebtModel model) {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('debts').doc(model.id).update(model.toJson());
  }

  @override
  Stream<DebtModel> getDebtChanges(String id) {
    final userReference = _firestore.collection('users').doc(_auth.currentUser!.uid);
    return userReference.collection('debts').doc(id).snapshots().map(
      (snapshot) {
        return DebtModel.fromJson(snapshot.data()!);
      },
    );
  }
}
