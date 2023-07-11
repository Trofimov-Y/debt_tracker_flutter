part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;

  const factory SettingsState.success({
    required String summaryCurrencyCode,
    required bool summaryEnabled,
  }) = _Success;

  const factory SettingsState.error() = _Error;
}
