import 'package:debt_tracker/data/datasources/remote/profile_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debts_summary_mapper.dart';
import 'package:debt_tracker/data/models/debts_summary_model.dart';
import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:debt_tracker/domain/utils/repository_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl with RepositoryMixin implements ProfileRepository {
  const ProfileRepositoryImpl(
    this._debtsSummaryMapper,
    this._profileRemoteDataSource,
  );

  final DebtsSummaryMapper _debtsSummaryMapper;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  @override
  Stream<DebtsSummary> getDebtsSummaryChanges() {
    return wrapStream(
      _profileRemoteDataSource.getDebtsSummaryChanges().map(
        (model) {
          return _debtsSummaryMapper.convert<DebtsSummaryModel, DebtsSummary>(model);
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> setSummaryCurrencyCode(String currencyCode) {
    final task = createTask(
      () => _profileRemoteDataSource.setSummaryCurrencyCode(currencyCode),
      (_) => const Failure.setSummaryCurrencyCode(),
    );
    return task.run();
  }

  @override
  Stream<String> getSummaryCurrencyCodeChanges() {
    return wrapStream(_profileRemoteDataSource.getSummaryCurrencyCodeChanges());
  }

  @override
  Stream<bool> getSummaryStatusChanges() {
    return wrapStream(_profileRemoteDataSource.getSummaryStatusChanges());
  }

  @override
  Future<Either<Failure, void>> setSummaryStatus(bool status) {
    final task = createTask(
      () => _profileRemoteDataSource.setSummaryStatus(status),
      (_) => const Failure.setSummaryStatus(),
    );
    return task.run();
  }
}
