import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePersistentHeaderDelegate extends SliverPinnedPersistentHeaderDelegate {
  HomePersistentHeaderDelegate({
    required super.minExtentProtoType,
    required super.maxExtentProtoType,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    double? minExtent,
    double maxExtent,
    bool overlapsContent,
  ) {
    final isCollapsed = maxExtent - shrinkOffset <= (minExtent ?? 0);

    final collapseAnimationPercentage = double.parse(
      (1 - (shrinkOffset / (maxExtent - (minExtent ?? 0))).clamp(0, 1)).toStringAsFixed(1),
    );

    return ColoredBox(
      color: context.colors.background,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (!isCollapsed) ...[
            Positioned(
              top: -shrinkOffset,
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: collapseAnimationPercentage,
                duration: const Duration(milliseconds: 100),
                child: maxExtentProtoType,
              ),
            ),
          ],
          if (isCollapsed) ...[
            Positioned(
              top: context.mediaQuery.padding.top,
              left: 0,
              right: 0,
              child: minExtentProtoType,
            ).animate().fadeIn(),
          ],
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPinnedPersistentHeaderDelegate oldDelegate) {
    return maxExtentProtoType != oldDelegate.maxExtentProtoType ||
        minExtentProtoType != oldDelegate.minExtentProtoType;
  }
}
