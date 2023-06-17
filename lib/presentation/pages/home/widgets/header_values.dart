import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class HeaderValues extends StatelessWidget {
  const HeaderValues({
    super.key,
    required this.myDebt,
    required this.oweMe,
    this.decimalPlaces = 2,
    required this.currencySymbol,
  });
  final double myDebt;
  final double oweMe;
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
                'Owe me',
                style: context.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                '${oweMe.toStringAsFixed(decimalPlaces)} $currencySymbol',
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
                'My Debt',
                style: context.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                '${myDebt.toStringAsFixed(decimalPlaces)} $currencySymbol',
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
