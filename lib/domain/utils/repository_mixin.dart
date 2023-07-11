import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

mixin RepositoryMixin {
  TaskEither<Failure, T> createTask<T>(
    Future<T> Function() job,
    Failure Function(Object error) onError,
  ) {
    final task = TaskEither.tryCatch(() {
      GetIt.instance.get<Logger>().i(job);
      return job();
    }, (error, stackTrace) {
      GetIt.instance.get<Logger>().e(error.toString(), error, stackTrace);
      return onError(error);
    });
    return task;
  }

  Stream<T> wrapStream<T>(Stream<T> stream) {
    return stream.doOnData(
      (event) {
        GetIt.instance.get<Logger>().i(event);
      },
    ).doOnError((error, stackTrace) {
      GetIt.instance.get<Logger>().e(error.toString(), error, stackTrace);
    });
  }
}
