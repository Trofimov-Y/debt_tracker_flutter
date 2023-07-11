part 'authentication_failures.dart';

part 'debts_failures.dart';

part 'profile_failures.dart';

part 'settings_failures.dart';

sealed class Failure {
  const Failure({this.error});

  final Object? error;
}
