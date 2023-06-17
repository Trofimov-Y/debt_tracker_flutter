import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderActionsButtons extends StatelessWidget {
  const HeaderActionsButtons({
    super.key,
    required this.onAddEntryPressed,
    required this.onRemindPressed,
    required this.onAllEntriesPressed,
  });

  final VoidCallback onAddEntryPressed;
  final VoidCallback onRemindPressed;
  final VoidCallback onAllEntriesPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _HeaderButton(
            icon: Icons.add,
            onPressed: onAddEntryPressed,
            text: 'Add an entry',
          ),
        ),
        const Gap(28),
        Expanded(
          child: _HeaderButton(
            icon: Icons.notifications,
            onPressed: onRemindPressed,
            text: 'Remind',
          ),
        ),
        const Gap(28),
        Expanded(
          child: _HeaderButton(
            icon: Icons.notes,
            onPressed: onAllEntriesPressed,
            text: 'All Entries',
          ),
        ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.secondaryContainer,
            borderRadius: BorderRadius.circular(64),
          ),
          child: IconButton(
            icon: Icon(icon, color: context.colors.primary, size: 32),
            onPressed: onPressed,
          ),
        ),
        const Gap(8),
        Text(text, style: context.textTheme.bodySmall, textAlign: TextAlign.center),
      ],
    );
  }
}
