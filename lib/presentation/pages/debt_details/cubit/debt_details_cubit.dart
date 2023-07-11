import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/delete_debt_usecase.dart';
import 'package:debt_tracker/domain/usecases/edit_debt_usecase.dart';
import 'package:debt_tracker/domain/usecases/get_debt_changes_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'debt_details_cubit.freezed.dart';

part 'debt_details_state.dart';

@injectable
class DebtDetailsCubit extends Cubit<DebtDetailsState> {
  DebtDetailsCubit(
    this._getDebtChangesUseCase,
    this._editDebtUseCase,
    this._deleteDebtUseCase,
    @factoryParam this.debtId,
  ) : super(const DebtDetailsState.initial()) {
    _onCreate();
  }

  final String debtId;

  final GetDebtChangesUseCase _getDebtChangesUseCase;
  final EditDebtUseCase _editDebtUseCase;
  final DeleteDebtUseCase _deleteDebtUseCase;

  StreamSubscription<DebtEntity>? _debtChangesSubscription;

  void _onCreate() {
    _debtChangesSubscription = _getDebtChangesUseCase(debtId).listen(
      (debt) {
        emit(DebtDetailsState.success(debt));
      },
      onError: (failure) {
        emit(const DebtDetailsState.error(DebtsConnectionFailure()));
      },
    );
  }

  Future<void> onDeletePressed() async {
    state.mapOrNull(
      success: (state) {
        final result = _deleteDebtUseCase(state.debt.id!);
      },
    );
  }

  Future<void> onEditPressed() async {
    state.mapOrNull(
      success: (state) {
        final result = _editDebtUseCase(
          state.debt.copyWith(
            amount: 100,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    _debtChangesSubscription?.cancel();
    return super.close();
  }
}
