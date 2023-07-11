import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

final _cubitsLogger = Logger(printer: PrettyPrinter());

mixin CubitMixin {
  TaskEither<Failure, T> createTask<T>(
    Future<T> Function() job,
    Failure Function(Object error) onError,
  ) {
    final task = TaskEither.tryCatch(() {
      return job();
    }, (error, stackTrace) {
      _cubitsLogger.e(error.toString(), error, stackTrace);
      return onError(error);
    });
    return task;
  }
}
