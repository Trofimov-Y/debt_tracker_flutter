import 'package:debt_tracker/core/extensions/bool_extensions.dart';
import 'package:debt_tracker/domain/entities/debt_feed_action.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedActionListTile extends StatelessWidget {
  const FeedActionListTile({
    super.key,
    required this.onTap,
    required this.action,
  });

  final FeedAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        child: switch (action.type) {
          ActionType.create => const Icon(Icons.add_circle_outline_rounded),
          ActionType.delete => const Icon(Icons.delete_outline_rounded),
          ActionType.partialRepayment => const Icon(Icons.attach_money_outlined),
          ActionType.fullRepayment => const Icon(Icons.money_off_csred_outlined),
          ActionType.partialAdditionDebt => const Icon(Icons.attach_money_outlined),
        },
      ),
      title: Text(action.debtName),
      subtitle: Text(
        switch (action.type) {
          ActionType.create => 'New debt',
          ActionType.delete => 'Delete debt',
          ActionType.partialRepayment => 'Partial debt repayment',
          ActionType.fullRepayment => 'Full debt repayment',
          ActionType.partialAdditionDebt => 'Partial addition debt',
        },
      ),
      trailing: (action.amount != null && action.currencyCode != null).whenOrNull(
        () => Text(
          '${action.amount?.toStringAsFixed(2)} ${NumberFormat.simpleCurrency(
            name: action.currencyCode,
          ).currencySymbol}',
          style: context.textTheme.bodyLarge?.medium,
        ),
      ),
    );
  }
}
