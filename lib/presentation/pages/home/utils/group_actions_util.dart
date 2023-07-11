import 'package:debt_tracker/domain/entities/debt_feed_action.dart';

Map<DateTime, List<FeedAction>> groupActionsByDate(List<FeedAction> actions) {
  final actionsByDay = <DateTime, List<FeedAction>>{};
  for (final action in actions) {
    final date = DateTime(action.createdAt.year, action.createdAt.month, action.createdAt.day);
    if (!actionsByDay.containsKey(date)) {
      actionsByDay[date] = [];
    }
    actionsByDay[date]!.add(action);
  }
  return actionsByDay;
}
