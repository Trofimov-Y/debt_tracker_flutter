import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/create_dept_usecase.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'new_debt_cubit.freezed.dart';

part 'new_debt_state.dart';

@injectable
class NewDebtCubit extends Cubit<NewDebtState> {
  NewDebtCubit(
    this._createDebtUseCase,
    this._router,
  ) : super(NewDebtState.data(type: DebtType.toMe, incurredDate: DateTime.now()));

  final AppRouter _router;
  final CreateDebtUseCase _createDebtUseCase;

  void changeDebtType(DebtType type) {
    emit(state.copyWith(type: type));
  }

  void changeDueDate(DateTime date) {
    emit(state.copyWith(dueDate: date));
  }

  void changeIncurredDate(DateTime date) {
    emit(state.copyWith(incurredDate: date));
  }

  Future<void> onCreatePressed({
    required String name,
    required String description,
    required double amount,
    required String currencyCode,
  }) async {
    emit(
      NewDebtState.loading(
        type: state.type,
        incurredDate: state.incurredDate,
        dueDate: state.dueDate,
      ),
    );

    final result = await _createDebtUseCase(
      DebtEntity(
        id: null,
        name: name,
        description: description,
        amount: amount,
        incurredDate: state.incurredDate,
        dueDate: state.dueDate,
        type: state.type,
        currencyCode: currencyCode,
      ),
    );
    result.fold(
      (failure) {
        emit(
          NewDebtState.error(
            type: state.type,
            incurredDate: state.incurredDate,
            dueDate: state.dueDate,
            failure: failure,
          ),
        );
      },
      (_) => _router.pop(),
    );
  }
}
