import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/get_debts_changes_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'all_debts_cubit.freezed.dart';

part 'all_debts_state.dart';

@injectable
class AllDebtsCubit extends Cubit<AllDebtsState> {
  AllDebtsCubit(
    this._getDebtsChangesUseCase,
  ) : super(const AllDebtsState.initial()) {
    _onCreate();
  }

  final GetDebtsChangesUseCase _getDebtsChangesUseCase;

  StreamSubscription<List<DebtEntity>>? _debtsChangesSubscription;

  Future<void> onRetryPressed() async {
    emit(const AllDebtsState.initial());
    await _debtsChangesSubscription?.cancel();
    _debtsChangesSubscription = null;
    _onCreate();
  }

  Future<void> _onCreate() async {
    _debtsChangesSubscription ??= _getDebtsChangesUseCase().listen(
      (debts) {
        emit(
          AllDebtsState.success(
            debts.where((debt) => debt.type == DebtType.toMe).toList(),
            debts.where((debt) => debt.type == DebtType.byMe).toList(),
          ),
        );
      },
      onError: (error) {
        emit(const AllDebtsState.error(FailureWhenGettingDebts()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _debtsChangesSubscription?.cancel();
    return super.close();
  }
}
