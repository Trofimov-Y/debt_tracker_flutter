import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.title,
    this.message,
    this.onRetryPressed,
  });

  final String? title;
  final String? message;
  final VoidCallback? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48),
        const Gap(8),
        Text(
          title ?? S.of(context).somethingWentWrong,
          style: context.textTheme.titleLarge,
        ),
        const Gap(8),
        Text(
          message ?? S.of(context).pleaseTryAgainLater,
          style: context.textTheme.bodyMedium,
        ),
        const Gap(16),
        if (onRetryPressed != null) ...[
          FilledButton.tonal(
            onPressed: onRetryPressed,
            child: Text(S.of(context).retry),
          ),
        ],
      ],
    );
  }
}
