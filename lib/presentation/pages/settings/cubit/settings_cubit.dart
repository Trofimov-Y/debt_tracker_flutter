import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/usecases/delete_profile_usecase.dart';
import 'package:debt_tracker/domain/usecases/get_summary_currency_code_changes_usecase.dart';
import 'package:debt_tracker/domain/usecases/get_summary_status_changes_usecase.dart';
import 'package:debt_tracker/domain/usecases/set_summary_currency_code_usecase.dart';
import 'package:debt_tracker/domain/usecases/set_summary_status_usecase.dart';
import 'package:debt_tracker/domain/usecases/sign_out_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'settings_cubit.freezed.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._getSummaryStatusChangesUseCase,
    this._setSummaryStatusUseCase,
    this._setSummaryCurrencyCodeUseCase,
    this._getSummaryCurrencyCodeChangesUseCase,
    this._signOutUseCase,
    this._deleteProfileUseCase,
  ) : super(const SettingsState.initial()) {
    _onCreate();
  }

  final SignOutUseCase _signOutUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  final SetSummaryStatusUseCase _setSummaryStatusUseCase;
  final SetSummaryCurrencyCodeUseCase _setSummaryCurrencyCodeUseCase;

  final GetSummaryStatusChangesUseCase _getSummaryStatusChangesUseCase;
  final GetSummaryCurrencyCodeChangesUseCase _getSummaryCurrencyCodeChangesUseCase;

  StreamSubscription<(bool, String)>? _summarySubscription;

  Future<void> onSignOutTap() async {
    _signOutUseCase();
  }

  Future<void> onRetryPressed() async {
    emit(const SettingsState.initial());
    await _summarySubscription?.cancel();
    _summarySubscription = null;
    _onCreate();
  }

  Future<void> onDeleteProfileTap() async {
    _deleteProfileUseCase();
  }

  void onSummaryStatusChanged(bool value) {
    _setSummaryStatusUseCase(value);
  }

  void onSummaryCurrencyCodeChanged(String value) {
    _setSummaryCurrencyCodeUseCase(value);
  }

  void _onCreate() {
    _summarySubscription ??= Rx.combineLatest2(
      _getSummaryStatusChangesUseCase(),
      _getSummaryCurrencyCodeChangesUseCase(),
      (summaryEnabled, summaryCurrencyCode) {
        return (summaryEnabled, summaryCurrencyCode);
      },
    ).listen(
      (event) {
        emit(
          SettingsState.success(summaryEnabled: event.$1, summaryCurrencyCode: event.$2),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _summarySubscription?.cancel();
    return super.close();
  }
}
