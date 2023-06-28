import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class DebtsRemoteDataSource {
  Stream<List<DebtModel>> getDebtsChanges();

  Future<void> createDebt(DebtModel model);
}

@Injectable(as: DebtsRemoteDataSource)
final class DebtsRemoteDataSourceImpl implements DebtsRemoteDataSource {
  const DebtsRemoteDataSourceImpl(
    this._firebaseAuthInstance,
    this._firestore,
  );

  final FirebaseAuth _firebaseAuthInstance;
  final FirebaseFirestore _firestore;

  @override
  Future<void> createDebt(DebtModel model) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuthInstance.currentUser!.uid)
        .collection('debts')
        .add(model.toJson());
  }

  @override
  Stream<List<DebtModel>> getDebtsChanges() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuthInstance.currentUser!.uid)
        .collection('debts')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DebtModel.fromJson(doc.data()..addAll({'id': doc.id})))
              .toList(),
        );
  }
}
