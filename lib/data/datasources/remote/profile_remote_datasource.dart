import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debt_tracker/data/models/debt_model.dart';
import 'package:debt_tracker/data/models/debts_summary_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ProfileRemoteDataSource {
  Stream<DebtsSummaryModel> getDebtsSummaryChanges();

  Future<void> setSummaryCurrencyCode(String currencyCode);

  Future<void> setSummaryStatus(bool status);

  Stream<String> getSummaryCurrencyCodeChanges();

  Stream<bool> getSummaryStatusChanges();
}

@Injectable(as: ProfileRemoteDataSource)
final class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(
    this._auth,
    this._firestore,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<DebtsSummaryModel> getDebtsSummaryChanges() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots().flatMap((value) {
      final currencyCode = value.get('summaryCurrencyCode') as String;
      final snapshots = value.reference
          .collection('debts')
          .where('currencyCode', isEqualTo: currencyCode)
          .where('amount', isGreaterThan: 0.0)
          .snapshots();

      return snapshots.map(
        (values) {
          final debts = values.docs.map((debt) => DebtModel.fromJson(debt.data())).toList();
          final totalOwedByMe = debts.where((element) {
            return element.type == 'byMe';
          }).fold(
            0.0,
            (previousValue, element) => previousValue + element.amount,
          );
          final totalOwedToMe = debts.where((element) {
            return element.type == 'toMe';
          }).fold(
            0.0,
            (previousValue, element) => previousValue + element.amount,
          );
          return DebtsSummaryModel(
            totalOwedByMe: totalOwedByMe,
            totalOwedToMe: totalOwedToMe,
            currencyCode: currencyCode,
          );
        },
      );
    });
  }

  @override
  Stream<String> getSummaryCurrencyCodeChanges() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots().map(
          (value) => value.get('summaryCurrencyCode') as String,
        );
  }

  @override
  Future<void> setSummaryCurrencyCode(String currencyCode) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'summaryCurrencyCode': currencyCode});
  }

  @override
  Stream<bool> getSummaryStatusChanges() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots().map(
          (value) => value.get('summaryEnabled') as bool,
        );
  }

  @override
  Future<void> setSummaryStatus(bool status) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'summaryEnabled': status});
  }
}
