import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/debts_summary.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/get_debts_summary_chages_usecase.dart';
import 'package:debt_tracker/domain/usecases/get_summary_status_changes_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'debts_summary_cubit.freezed.dart';

part 'debts_summary_state.dart';

@injectable
class DebtsSummaryCubit extends Cubit<DebtsSummaryState> {
  DebtsSummaryCubit(
    this._getDebtsSummaryChangesUseCase,
    this._logger,
    this._getSummaryStatusChangesUseCase,
  ) : super(const DebtsSummaryState.initial()) {
    _onCreate();
  }

  final Logger _logger;
  final GetSummaryStatusChangesUseCase _getSummaryStatusChangesUseCase;
  final GetDebtsSummaryChangesUseCase _getDebtsSummaryChangesUseCase;

  StreamSubscription<DebtsSummary>? _debtsSummarySubscription;
  StreamSubscription<bool>? _summaryStatusSubscription;

  Future<void> onRetryPressed() async {
    emit(const DebtsSummaryState.initial());
    await _debtsSummarySubscription?.cancel();
    _debtsSummarySubscription = null;
    _onCreate();
  }

  Future<void> _onCreate() async {
    _summaryStatusSubscription ??= _getSummaryStatusChangesUseCase().listen(
      (status) {
        if (status) {
          _subscribeSummaryChanges();
        } else {
          emit(const DebtsSummaryState.initial());
          _debtsSummarySubscription?.cancel();
          _debtsSummarySubscription = null;
        }
      },
      onError: (error) {
        _logger.e(error);
        emit(const DebtsSummaryState.error(DebtsConnectionFailure()));
      },
    );
  }

  void _subscribeSummaryChanges() {
    _debtsSummarySubscription ??= _getDebtsSummaryChangesUseCase().listen(
      (summary) {
        emit(DebtsSummaryState.success(summary));
      },
      onError: (error) {
        _logger.e(error);
        emit(const DebtsSummaryState.error(DebtsConnectionFailure()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _summaryStatusSubscription?.cancel();
    await _debtsSummarySubscription?.cancel();
    return super.close();
  }
}
