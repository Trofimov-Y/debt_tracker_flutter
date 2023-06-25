part of 'welcome_cubit.dart';

@freezed
class WelcomeState with _$WelcomeState {
  const factory WelcomeState.initial() = _Initial;

  const factory WelcomeState.success() = _Success;

  const factory WelcomeState.error(Failure failure) = _Error;

  const factory WelcomeState.loading() = _Loading;
}
