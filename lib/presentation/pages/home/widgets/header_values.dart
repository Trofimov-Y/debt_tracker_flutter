import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class HeaderValues extends StatelessWidget {
  const HeaderValues({
    super.key,
    required this.owedByMe,
    required this.owedToMe,
    this.decimalPlaces = 2,
    required this.currencySymbol,
  });
  final double owedByMe;
  final double owedToMe;
  final int decimalPlaces;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                S.of(context).owedToMe,
                style: context.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                '${owedToMe.toStringAsFixed(decimalPlaces)} $currencySymbol',
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.end,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                S.of(context).owedByMe,
                style: context.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                '${owedByMe.toStringAsFixed(decimalPlaces)} $currencySymbol',
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.end,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
