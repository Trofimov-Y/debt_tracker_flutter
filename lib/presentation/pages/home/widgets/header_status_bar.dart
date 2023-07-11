import 'package:debt_tracker/core/extensions/double_extensions.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderStatusBar extends StatelessWidget {
  const HeaderStatusBar({
    super.key,
    required this.owedByMe,
    required this.owedToMe,
    required this.currencySymbol,
    this.decimalPlaces = 2,
  });




  final double owedByMe;
  final double owedToMe;

  final int decimalPlaces;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final owedByMeParts = owedByMe.separateParts(decimalPlaces);
    final owedToMeParts = owedToMe.separateParts(decimalPlaces);
    return Row(
      children: [
        Expanded(
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(text: '${owedToMeParts.$1}', style: context.textTheme.titleLarge),
                TextSpan(text: '.${owedToMeParts.$2}', style: context.textTheme.titleSmall),
              ],
            ),
          ),
        ),
        const Gap(8),
        Text('|', style: context.textTheme.titleLarge),
        const Gap(8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '${owedByMeParts.$1}', style: context.textTheme.titleLarge),
                TextSpan(text: '.${owedByMeParts.$2}', style: context.textTheme.titleSmall),
                const WidgetSpan(child: SizedBox(width: 4)),
                TextSpan(text: currencySymbol, style: context.textTheme.titleLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
