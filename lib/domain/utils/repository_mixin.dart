import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

final _repositoriesLogger = Logger(printer: PrettyPrinter());

mixin RepositoryMixin {
  TaskEither<Failure, T> createTask<T>(
    Future<T> Function() job,
    Failure Function(Object error) onError,
  ) {
    final task = TaskEither.tryCatch(() {
      _repositoriesLogger.i(job);
      return job();
    }, (error, stackTrace) {
      _repositoriesLogger.e(error.toString(), error, stackTrace);
      return onError(error);
    });
    return task;
  }

  Stream<T> wrapStream<T>(Stream<T> stream) {
    stream.doOnError((error, stackTrace) {
      _repositoriesLogger.e(error.toString(), error, stackTrace);
    });
    return stream;
  }
}
