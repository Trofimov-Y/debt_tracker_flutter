import 'package:bloc/bloc.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'new_debt_state.dart';
part 'new_debt_cubit.freezed.dart';

enum DebtType { toMe, byMe }

@injectable
class NewDebtCubit extends Cubit<NewDebtState> {
  NewDebtCubit(
    this._router,
  ) : super(NewDebtState.data(type: DebtType.toMe, incurredDate: DateTime.now()));

  final AppRouter _router;

  void changeDebtType(DebtType type) {
    emit(state.copyWith(type: type));
  }

  void changeDueDate(DateTime date) {
    emit(state.copyWith(dueDate: date));
  }

  void changeIncurredDate(DateTime date) {
    emit(state.copyWith(incurredDate: date));
  }
}
