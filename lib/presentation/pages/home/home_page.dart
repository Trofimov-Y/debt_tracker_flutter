import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:debt_tracker/core/extensions/date_time_extensions.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/pages/home/delegates/home_persistent_header_delegate.dart';
import 'package:debt_tracker/presentation/pages/home/home_page.test.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_actions_buttons.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_status_bar.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_values.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/operation_list_tile.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final operationsByDay = getOperationsByDay(operations);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverPinnedPersistentHeader(
            delegate: HomePersistentHeaderDelegate(
              minExtentProtoType: Container(
                height: 56 + context.mediaQuery.padding.top,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 16),
                child: const HeaderStatusBar(currencySymbol: '\$', owedByMe: debt, owedToMe: owed),
              ),
              maxExtentProtoType: Container(
                height: 220 + context.mediaQuery.padding.top,
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 16),
                child: Column(
                  children: [
                    const Expanded(
                      child: HeaderValues(currencySymbol: '\$', owedByMe: debt, owedToMe: owed),
                    ),
                    HeaderActionsButtons(
                      onNewDebtPressed: () {
                        context.router.push(const NewDebtRoute());
                      },
                      onAllEntriesPressed: () {
                        context.router.push(const EntriesRoute());
                      },
                      onSettingsPressed: () {
                        context.router.push(const SettingsRoute());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverClip(
            child: MultiSliver(
              children: List.generate(operationsByDay.length, (index) {
                final date = operationsByDay.keys.elementAt(index);
                final operations = operationsByDay[date];
                return SliverStickyHeader.builder(
                  builder: (context, state) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      color: Color.lerp(
                        context.colors.background,
                        ElevationOverlay.applySurfaceTint(
                          context.colors.surface,
                          context.colors.surfaceTint,
                          3,
                        ),
                        state.isPinned ? 1 - state.scrollPercentage : state.scrollPercentage,
                      ),
                      height: 56,
                      alignment: Alignment.center,
                      child: Text(
                        date.isToday ? S.of(context).today : date.dMMMMFormat,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurface,
                          fontWeight: state.isPinned ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    );
                  },
                  sliver: SliverList.builder(
                    itemCount: operations!.length,
                    itemBuilder: (context, index) {
                      final operation = operations[index];
                      return OperationListTile(
                        onTap: () {},
                        operationContactAvatarUrl: operation.contact.avatarUrl,
                        operationContactFullName: operation.contact.name,
                        operationValue: operation.value,
                        type: operation.type.toString(),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: context.colors.surface,
              height: context.mediaQuery.padding.bottom + 8,
            ),
          ),
        ],
      ),
    );
  }
}
