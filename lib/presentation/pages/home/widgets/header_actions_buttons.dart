import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderActionsButtons extends StatelessWidget {
  const HeaderActionsButtons({
    super.key,
    required this.onNewDebtPressed,
    required this.onAllEntriesPressed,
    required this.onSettingsPressed,
  });

  final VoidCallback onNewDebtPressed;
  final VoidCallback onAllEntriesPressed;
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _HeaderButton(
              icon: Icons.add_rounded,
              onPressed: onNewDebtPressed,
              text: S.of(context).newDebt,
            ),
          ),
        ),
        const Gap(4),
        Expanded(
          child: Align(
            child: _HeaderButton(
              icon: Icons.layers_rounded,
              onPressed: onAllEntriesPressed,
              text: S.of(context).allDebts,
            ),
          ),
        ),
        const Gap(4),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: _HeaderButton(
              icon: Icons.settings_rounded,
              onPressed: onSettingsPressed,
              text: S.of(context).settings,
            ),
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
        Text(text, style: context.textTheme.bodySmall?.medium, textAlign: TextAlign.center),
      ],
    );
  }
}
