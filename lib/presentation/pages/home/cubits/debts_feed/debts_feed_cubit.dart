import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/get_debts_feed_changes_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'debts_feed_cubit.freezed.dart';

part 'debts_feed_state.dart';

@injectable
class DebtsFeedCubit extends Cubit<DebtsFeedState> {
  DebtsFeedCubit(
    this._getDebtsFeedChangesUseCase,
  ) : super(const DebtsFeedState.initial()) {
    _onCreate();
  }

  final GetDebtsFeedChangesUseCase _getDebtsFeedChangesUseCase;

  StreamSubscription<List<FeedAction>>? _debtsFeedChangesSubscription;

  Future<void> onRetryPressed() async {
    emit(const DebtsFeedState.initial());
    await _debtsFeedChangesSubscription?.cancel();
    _debtsFeedChangesSubscription = null;
    _onCreate();
  }

  Future<void> _onCreate() async {
    _debtsFeedChangesSubscription ??= _getDebtsFeedChangesUseCase().listen(
      (actions) {
        emit(DebtsFeedState.success(actions));
      },
      onError: (error) {
        emit(const DebtsFeedState.error(FailureWhenGettingFeed()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _debtsFeedChangesSubscription?.cancel();
    return super.close();
  }
}
