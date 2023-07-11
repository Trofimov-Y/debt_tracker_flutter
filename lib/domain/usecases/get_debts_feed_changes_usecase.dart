import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/domain/repositories/debts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDebtsFeedChangesUseCase {
  const GetDebtsFeedChangesUseCase(this._debtsRepository);

  final DebtsRepository _debtsRepository;

  Stream<List<FeedAction>> call() => _debtsRepository.getDebtsFeedChanges();
}
