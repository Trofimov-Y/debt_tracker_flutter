import 'package:debt_tracker/data/datasources/remote/profile_remote_datasource.dart';
import 'package:debt_tracker/data/mappers/debts_summary_mapper.dart';
import 'package:debt_tracker/data/models/debts_summary_model.dart';
import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(
    this._debtsSummaryMapper,
    this._logger,
    this._profileRemoteDataSource,
  );

  final Logger _logger;
  final DebtsSummaryMapper _debtsSummaryMapper;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  @override
  Stream<DebtsSummary> getDebtsSummaryChanges() {
    return _profileRemoteDataSource.getDebtsSummaryChanges().map(
          (value) => _debtsSummaryMapper.convert<DebtsSummaryModel, DebtsSummary>(value),
        );
  }

  @override
  Future<Either<Failure, void>> setSummaryCurrencyCode(String currencyCode) {
    return TaskEither.tryCatch(
      () {
        return _profileRemoteDataSource.setSummaryCurrencyCode(currencyCode);
      },
      (error, stackTrace) {
        _logger.e(error.toString(), error, stackTrace);
        return GeneraFailure(error: error, stackTrace: stackTrace);
      },
    ).run();
  }

  @override
  Stream<String> getSummaryCurrencyCodeChanges() {
    return _profileRemoteDataSource.getSummaryCurrencyCodeChanges();
  }

  @override
  Stream<bool> getSummaryStatusChanges() {
    return _profileRemoteDataSource.getSummaryStatusChanges();
  }

  @override
  Future<Either<Failure, void>> setSummaryStatus(bool status) {
    return TaskEither.tryCatch(
      () {
        return _profileRemoteDataSource.setSummaryStatus(status);
      },
      (error, stackTrace) {
        _logger.e(error.toString(), error, stackTrace);
        return GeneraFailure(error: error, stackTrace: stackTrace);
      },
    ).run();
  }
}
