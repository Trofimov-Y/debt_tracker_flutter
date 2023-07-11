import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

mixin CubitMixin {
  TaskEither<Failure, T> createTask<T>(
    Future<T> Function() job,
    Failure Function(Object error) onError,
  ) {
    final task = TaskEither.tryCatch(() {
      return job();
    }, (error, stackTrace) {
      GetIt.instance.get<Logger>().e(error.toString(), error, stackTrace);
      return onError(error);
    });
    return task;
  }
}
