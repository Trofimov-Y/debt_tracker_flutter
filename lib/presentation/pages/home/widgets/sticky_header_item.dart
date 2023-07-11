import 'package:dartx/dartx.dart';
import 'package:debt_tracker/core/extensions/date_time_extensions.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class StickyHeaderItem extends StatelessWidget {
  const StickyHeaderItem({
    required this.isPinned,
    required this.dateTime,
    required this.scrollPercentage,
  });

  final bool isPinned;
  final double scrollPercentage;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.lerp(
        context.colors.background,
        ElevationOverlay.applySurfaceTint(
          context.colors.surface,
          context.colors.surfaceTint,
          3,
        ),
        isPinned ? 1 - scrollPercentage : scrollPercentage,
      ),
      height: 56,
      alignment: Alignment.center,
      child: Text(
        dateTime.isToday ? S.of(context).today : dateTime.dMMMMFormat,
        style: context.textTheme.bodyMedium?.medium.copyWith(
          color: context.colors.onSurface,
        ),
      ),
    );
  }
}
