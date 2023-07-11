import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, void>> setSummaryCurrencyCode(String currencyCode);

  Future<Either<Failure, void>> setSummaryStatus(bool status);

  Stream<String> getSummaryCurrencyCodeChanges();

  Stream<DebtsSummary> getDebtsSummaryChanges();

  Stream<bool> getSummaryStatusChanges();
}
