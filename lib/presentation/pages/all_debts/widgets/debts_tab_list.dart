part of '../all_debts_page.dart';

class _DebtsTabList extends StatelessWidget {
  const _DebtsTabList({
    required this.debts,
    required this.pageStorageKey,
    required this.onTileTap,
  });

  final Function(String debtId) onTileTap;
  final PageStorageKey pageStorageKey;
  final List<DebtEntity> debts;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: debts.isEmpty.when(
        () => const NeverScrollableScrollPhysics(),
        () => const BouncingScrollPhysics(),
      ),
      key: pageStorageKey,
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        if (debts.isEmpty) ...[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: EmptyStateWidget(
                title: S.of(context).noDebts,
                message: S.of(context).tryCreateEntry,
              ),
            ),
          ),
        ],
        SliverList.builder(
          itemBuilder: (context, index) {
            final debt = debts[index];
            return _DebtListTile(
              debt: debt,
              onTap: onTileTap,
            );
          },
          itemCount: debts.length,
        ),
        SliverGap(context.padding.bottom + 8)
      ],
    );
  }
}

class _DebtListTile extends StatelessWidget {
  const _DebtListTile({
    required this.debt,
    required this.onTap,
  });

  final Function(String id) onTap;
  final DebtEntity debt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      title: Text(
        debt.name.capitalize(),
        style: const TextStyle(fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '${debt.amount.toStringAsFixed(2)} ${NumberFormat.simpleCurrency(
          name: debt.currencyCode,
        ).currencySymbol}',
        style: context.textTheme.bodyLarge?.medium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => onTap(debt.id!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Incurred: ',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colors.secondary),
                ),
                TextSpan(
                  text: debt.incurredDate.EEEddMMMFormat,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (debt.dueDate != null) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Due: ',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.secondary,
                    ),
                  ),
                  TextSpan(
                    text: debt.dueDate!.EEEddMMMFormat,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
