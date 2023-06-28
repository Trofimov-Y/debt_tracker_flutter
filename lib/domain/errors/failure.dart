part 'authentication_failures.dart';

part 'debts_failures.dart';

sealed class Failure {
  const Failure({this.error});

  final Object? error;
}

final class GeneraFailure extends Failure {
  const GeneraFailure({
    required super.error,
    required this.stackTrace,
  });

  final StackTrace stackTrace;
}
