import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DebtsRepository {
  Stream<List<DebtEntity>> getDebtsChanges();

  Stream<List<FeedAction>> getDebtsFeedChanges();

  Future<Either<Failure, void>> createDebt(DebtEntity entity);
}
