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
              onTap: (String id) {},
            );
          },
          itemCount: debts.length,
        ),
        SliverGap(context.padding.bottom + 88)
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: debt.avatarUrl == null ? null : NetworkImage(debt.avatarUrl!),
        child: debt.avatarUrl == null ? const Icon(Icons.person, size: 28) : null,
      ),
      title: Text(debt.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Text(debt.amount.toStringAsFixed(2), style: context.textTheme.bodyLarge?.medium),
      onTap: () => onTap(debt.id!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (debt.description.isNotEmpty) ...[
            Text(
              debt.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${S.of(context).incurredDate}: ',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.secondary,
                  ),
                ),
                TextSpan(
                  text: debt.incurredDate.EEEddMMMFormat,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (debt.dueDate != null) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${S.of(context).dueDate}: ',
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
            ),
          ],
        ],
      ),
    );
  }
}
