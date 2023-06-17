import 'package:debt_tracker/core/extensions/double_extensions.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class HeaderStatusBar extends StatelessWidget {
  const HeaderStatusBar({
    super.key,
    required this.myDebt,
    required this.oweMe,
    required this.currencySymbol,
    this.decimalPlaces = 2,
  });

  final double myDebt;
  final double oweMe;
  final int decimalPlaces;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final myDebtParts = myDebt.separateParts(decimalPlaces);
    final oweMeParts = oweMe.separateParts(decimalPlaces);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '${myDebtParts.$1}', style: context.textTheme.titleLarge),
          TextSpan(text: '.${myDebtParts.$2}', style: context.textTheme.titleSmall),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(text: '|', style: context.textTheme.titleLarge),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(text: '${oweMeParts.$1}', style: context.textTheme.titleLarge),
          TextSpan(text: '.${oweMeParts.$2}', style: context.textTheme.titleSmall),
          const WidgetSpan(child: SizedBox(width: 4)),
          TextSpan(text: currencySymbol, style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}
